import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'examination_repository.g.dart';

@riverpod
ExaminationRepository examinationRepository(Ref ref) {
  return ExaminationRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Future<List<CommandmentWithQuestions>> examinationData(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final contentLanguage = await ref.watch(
    contentLanguageControllerProvider.future,
  );

  final commandments =
      await (db.select(db.commandments)..where(
        (tbl) => tbl.languageCode.equals(contentLanguage.languageCode),
      )).get();
  final questions =
      await (db.select(db.examinationQuestions)..where(
        (tbl) => tbl.languageCode.equals(contentLanguage.languageCode),
      )).get();

  return commandments.map((c) {
    final relatedQuestions =
        questions.where((q) => q.commandmentId == c.id).toList();
    return CommandmentWithQuestions(c, relatedQuestions);
  }).toList();
}

class ExaminationRepository {
  ExaminationRepository(AppDatabase db);
}

class CommandmentWithQuestions {
  final Commandment commandment;
  final List<ExaminationQuestion> questions;

  CommandmentWithQuestions(this.commandment, this.questions);
}
