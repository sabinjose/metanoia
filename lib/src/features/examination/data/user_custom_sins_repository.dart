import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'user_custom_sins_repository.g.dart';

/// Repository for managing user custom sins
class UserCustomSinsRepository {
  final AppDatabase _db;

  UserCustomSinsRepository(this._db);

  /// Get all custom sins, optionally filtered by commandment code
  Future<List<UserCustomSin>> getAllCustomSins({
    String? commandmentCode,
  }) async {
    if (commandmentCode != null) {
      return await (_db.select(_db.userCustomSins)
            ..where((t) => t.commandmentCode.equals(commandmentCode))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
    }

    return await (_db.select(_db.userCustomSins)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// Get custom sins for a specific commandment code
  Future<List<UserCustomSin>> getCustomSinsByCommandmentCode(
    String code,
  ) async {
    return await (_db.select(_db.userCustomSins)
          ..where((t) => t.commandmentCode.equals(code))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get standalone custom sins (not associated with any commandment)
  Future<List<UserCustomSin>> getStandaloneCustomSins() async {
    return await (_db.select(_db.userCustomSins)
          ..where((t) => t.commandmentCode.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Check if a question has been customized by the user
  Future<UserCustomSin?> getCustomVersionOfQuestion(int questionId) async {
    return await (_db.select(
      _db.userCustomSins,
    )..where((t) => t.originalQuestionId.equals(questionId))).getSingleOrNull();
  }

  /// Insert a new custom sin
  Future<int> insertCustomSin(UserCustomSinsCompanion sin) async {
    return await _db.into(_db.userCustomSins).insert(sin);
  }

  /// Update an existing custom sin
  Future<void> updateCustomSin(int id, UserCustomSinsCompanion sin) async {
    await (_db.update(_db.userCustomSins)..where(
      (t) => t.id.equals(id),
    )).write(sin.copyWith(updatedAt: Value(DateTime.now())));
  }

  /// Delete a custom sin
  Future<void> deleteCustomSin(int id) async {
    await (_db.delete(_db.userCustomSins)..where((t) => t.id.equals(id))).go();
  }

  /// Get custom sin by ID
  Future<UserCustomSin?> getCustomSinById(int id) async {
    return await (_db.select(_db.userCustomSins)
      ..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Group custom sins by commandment code
  Future<Map<String?, List<UserCustomSin>>>
  getCustomSinsGroupedByCommandment() async {
    final allSins = await getAllCustomSins();
    final Map<String?, List<UserCustomSin>> grouped = {};

    for (final sin in allSins) {
      if (!grouped.containsKey(sin.commandmentCode)) {
        grouped[sin.commandmentCode] = [];
      }
      grouped[sin.commandmentCode]!.add(sin);
    }

    return grouped;
  }
}

@riverpod
UserCustomSinsRepository userCustomSinsRepository(Ref ref) {
  return UserCustomSinsRepository(ref.watch(appDatabaseProvider));
}
