import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'gamification_database.g.dart';

@DataClassName('LeaderboardEntryRow')
class LeaderboardEntries extends Table {
  TextColumn get scope => text()();
  IntColumn get pageIndex => integer()();
  TextColumn get userId => text()();
  TextColumn get userName => text()();
  TextColumn get avatarUrl => text()();
  IntColumn get rank => integer()();
  IntColumn get xp => integer()();
  TextColumn get rankChange => text()();

  @override
  Set<Column<Object>> get primaryKey => {scope, pageIndex, userId};
}

@DataClassName('LeaderboardPageMetaRow')
class LeaderboardPageMeta extends Table {
  TextColumn get scope => text()();
  IntColumn get pageIndex => integer()();
  BoolColumn get hasNextPage => boolean()();
  IntColumn get updatedAtMillis => integer()();

  @override
  Set<Column<Object>> get primaryKey => {scope, pageIndex};
}

@DriftAccessor(tables: [LeaderboardEntries, LeaderboardPageMeta])
class LeaderboardDao extends DatabaseAccessor<GamificationDatabase>
    with _$LeaderboardDaoMixin {
  LeaderboardDao(super.db);

  Future<void> replaceLeaderboardPage({
    required String scope,
    required int pageIndex,
    required bool hasNextPage,
    required List<LeaderboardEntriesCompanion> rows,
  }) async {
    await transaction(() async {
      await (delete(leaderboardEntries)
            ..where(
              (t) => t.scope.equals(scope) & t.pageIndex.equals(pageIndex),
            ))
          .go();
      await batch((b) {
        for (final row in rows) {
          b.insert(leaderboardEntries, row);
        }
      });
      await into(leaderboardPageMeta).insertOnConflictUpdate(
        LeaderboardPageMetaCompanion.insert(
          scope: scope,
          pageIndex: pageIndex,
          hasNextPage: hasNextPage,
          updatedAtMillis: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });
  }

  Future<({List<LeaderboardEntryRow> rows, bool hasNextPage})?> readLeaderboardPage({
    required String scope,
    required int pageIndex,
  }) async {
    final meta = await (select(leaderboardPageMeta)
          ..where(
            (t) => t.scope.equals(scope) & t.pageIndex.equals(pageIndex),
          ))
        .getSingleOrNull();
    if (meta == null) {
      return null;
    }
    final rows = await (select(leaderboardEntries)
          ..where(
            (t) => t.scope.equals(scope) & t.pageIndex.equals(pageIndex),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.rank)]))
        .get();
    return (rows: rows, hasNextPage: meta.hasNextPage);
  }

  Future<void> clearLeaderboardScope(String scope) async {
    await (delete(leaderboardEntries)..where((t) => t.scope.equals(scope))).go();
    await (delete(leaderboardPageMeta)..where((t) => t.scope.equals(scope))).go();
  }
}

@DriftDatabase(tables: [LeaderboardEntries, LeaderboardPageMeta], daos: [LeaderboardDao])
final class GamificationDatabase extends _$GamificationDatabase {
  GamificationDatabase(super.e);

  @override
  int get schemaVersion => 1;

  factory GamificationDatabase.connect() {
    return GamificationDatabase(driftDatabase(name: 'gamification.sqlite'));
  }
}
