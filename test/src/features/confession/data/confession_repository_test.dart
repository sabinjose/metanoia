import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  test('markConfessionAsFinished updates confession', () async {
    final repository = container.read(confessionRepositoryProvider);

    // Create active confession
    final confessionId = await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now()),
            isFinished: const Value(false),
          ),
        );

    await repository.markConfessionAsFinished(confessionId);

    final confession =
        await (db.select(db.confessions)
          ..where((t) => t.id.equals(confessionId))).getSingle();

    expect(confession.isFinished, true);
    expect(confession.finishedAt, isNotNull);
  });

  test('activeConfession returns correct confession', () async {
    // Create finished confession
    await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now().subtract(const Duration(days: 1))),
            isFinished: const Value(true),
            finishedAt: Value(DateTime.now()),
          ),
        );

    // Create active confession
    final activeId = await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now()),
            isFinished: const Value(false),
          ),
        );

    // Add items to active confession
    await db
        .into(db.confessionItems)
        .insert(
          ConfessionItemsCompanion.insert(
            confessionId: activeId,
            questionId: const Value(1),
            content: 'Test Item',
          ),
        );

    final activeConfession = await container.read(
      activeConfessionProvider.future,
    );

    expect(activeConfession, isNotNull);
    expect(activeConfession!.confession.id, activeId);
    expect(activeConfession.items.length, 1);
    expect(activeConfession.items.first.content, 'Test Item');
  });

  test('deleteConfession removes confession and items', () async {
    final repository = container.read(confessionRepositoryProvider);

    final confessionId = await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(DateTime.now()),
            isFinished: const Value(true),
          ),
        );
    await db
        .into(db.confessionItems)
        .insert(
          ConfessionItemsCompanion.insert(
            confessionId: confessionId,
            questionId: const Value(1),
            content: 'Test Item',
          ),
        );

    await repository.deleteConfession(confessionId);

    final confessions = await db.select(db.confessions).get();
    expect(confessions, isEmpty);

    final items = await db.select(db.confessionItems).get();
    expect(items, isEmpty);
  });
}

class TestAppDatabase extends AppDatabase {
  TestAppDatabase(super.e);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Skip syncContent()
    },
  );
}
