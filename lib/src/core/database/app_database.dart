import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:math';

import 'tables.dart';

import 'data_loader.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Commandments,
    ExaminationQuestions,
    Faqs,
    Quotes,
    Confessions,
    ConfessionItems,
    UserSettings,
    GuideItems,
    Prayers,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await syncContent();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        // Add finishedAt column to confessions table
        await m.addColumn(confessions, confessions.finishedAt);
      }
      if (from < 3) {
        // Add Malayalam examination questions
        final commandmentsMl = await DataLoader.loadCommandments('ml');

        await batch((batch) {
          batch.insertAll(commandments, commandmentsMl);
        });

        final allCommandments = await select(commandments).get();
        final questionsMl = await DataLoader.loadQuestions(
          'ml',
          allCommandments,
        );

        await batch((batch) {
          batch.insertAll(examinationQuestions, questionsMl);
        });
      }
      if (from < 4) {
        // Add code column to commandments table
        await m.addColumn(commandments, commandments.code);

        // Populate code for existing rows
        // We can't easily do this in SQL without a complex update.
        // Since we are re-seeding or this is a dev app, we might just want to update them.
        // However, for a proper migration, we should iterate and update.
        // Or, since we have the data in JSON, we can just update based on ID if we assume IDs match.
        // But we are moving away from IDs.

        // Simple strategy: Update all existing rows to have a code based on their ID and language.
        // English (1-11) -> en-ID
        // Malayalam (12-22) -> ml-(ID-11)

        await customStatement(
          "UPDATE commandments SET code = 'en-' || id WHERE language_code = 'en'",
        );
        // For Malayalam, it's trickier with SQL concatenation if we want to subtract.
        // But we can just use the DataLoader to update them if we want.
        // Or just leave them nullable for now and let the next sync fix it?
        // No, code is unique, so it shouldn't be null if we enforce it. But we made it nullable in schema.

        // Actually, let's just re-seed the codes from the JSON.
        final allCommandments = await DataLoader.loadCommandments('en');
        final allCommandmentsMl = await DataLoader.loadCommandments('ml');

        await batch((batch) {
          for (var c in allCommandments) {
            batch.update(
              commandments,
              CommandmentsCompanion(code: c.code),
              where:
                  (tbl) =>
                      tbl.commandmentNo.equals(c.commandmentNo.value) &
                      tbl.languageCode.equals('en'),
            );
          }
          for (var c in allCommandmentsMl) {
            batch.update(
              commandments,
              CommandmentsCompanion(code: c.code),
              where:
                  (tbl) =>
                      tbl.commandmentNo.equals(c.commandmentNo.value) &
                      tbl.languageCode.equals('ml'),
            );
          }
        });
      }

      // Sync content after any upgrade to ensure latest JSON data is applied
      await syncContent();
    },
  );
  Future<void> syncContent() async {
    final languages = ['en', 'ml'];

    for (final lang in languages) {
      // 1. Sync Commandments
      final commandmentsData = await DataLoader.loadCommandments(lang);

      // We need to upsert commandments based on 'code'.
      // Since Drift doesn't have a simple upsert for this without ID, we check existence.
      for (final cmd in commandmentsData) {
        final existing =
            await (select(commandments)
              ..where((t) => t.code.equals(cmd.code.value!))).getSingleOrNull();

        if (existing != null) {
          // Update content if changed
          if (existing.content != cmd.content.value) {
            await update(
              commandments,
            ).replace(existing.copyWith(content: cmd.content.value));
          }
        } else {
          // Insert new
          await into(commandments).insert(cmd);
        }
      }

      // 2. Sync Questions
      // First, get all commandments to resolve codes
      final allCommandments = await select(commandments).get();
      final questionsData = await DataLoader.loadQuestions(
        lang,
        allCommandments,
      );

      final existingQuestions =
          await (select(examinationQuestions)
            ..where((t) => t.languageCode.equals(lang))).get();

      // Map existing questions by (commandmentId + question text) to find matches
      // Note: This assumes text doesn't change. If text changes, it's treated as a new question.
      final existingMap = {
        for (var q in existingQuestions) '${q.commandmentId}_${q.question}': q,
      };

      final idsToKeep = <int>{};

      for (final q in questionsData) {
        final key = '${q.commandmentId.value}_${q.question.value}';
        if (existingMap.containsKey(key)) {
          idsToKeep.add(existingMap[key]!.id);
        } else {
          // Insert new question
          await into(examinationQuestions).insert(q);
        }
      }

      // Identify questions to delete
      final idsToDelete =
          existingQuestions
              .map((q) => q.id)
              .where((id) => !idsToKeep.contains(id))
              .toList();

      if (idsToDelete.isNotEmpty) {
        // Unlink from ConfessionItems first
        await (update(confessionItems)..where(
          (t) => t.questionId.isIn(idsToDelete),
        )).write(const ConfessionItemsCompanion(questionId: Value(null)));

        // Delete questions
        await (delete(examinationQuestions)
          ..where((t) => t.id.isIn(idsToDelete))).go();
      }

      // 3. Sync FAQs (Full replace for simplicity as they have no dependencies)
      final faqsData = await DataLoader.loadFaqs(lang);
      await (delete(faqs)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(faqs, faqsData);
      });

      // 4. Sync Quotes (Full replace)
      final quotesData = await DataLoader.loadQuotes(lang);
      await (delete(quotes)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(quotes, quotesData);
      });

      // 5. Sync Guide Items (Full replace)
      final guideData = await DataLoader.loadGuide(lang);
      await (delete(guideItems)
        ..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(guideItems, guideData);
      });

      // 6. Sync Prayers (Full replace)
      final prayersData = await DataLoader.loadPrayers(lang);
      await (delete(prayers)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(prayers, prayersData);
      });
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'confession_app.sqlite'));

    // Encryption setup
    // Use encryptedSharedPreferences on Android for better stability
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );

    String? encryptionKey;
    try {
      encryptionKey = await secureStorage.read(key: 'db_key');
    } catch (e) {
      // If reading fails (e.g. key store issues), reset storage
      await secureStorage.deleteAll();
    }

    if (encryptionKey == null) {
      // Generate a new key
      final keyBytes = List<int>.generate(
        32,
        (_) => Random.secure().nextInt(256),
      );
      encryptionKey = base64Encode(keyBytes);
      await secureStorage.write(key: 'db_key', value: encryptionKey);
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute("PRAGMA key = '$encryptionKey';");
      },
    );
  });
}
