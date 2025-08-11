import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:myxpenses/core/core.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'drift.database.g.dart';

@Riverpod(keepAlive: true)
MyXpensesDatabase database(Ref ref) {
  final database = MyXpensesDatabase();
  debugLog(
    'Database open schema: ${database.schemaVersion}',
    name: 'db',
  );
  return database;
}

class AccountsTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get name => text().unique()();
}

class ExpensesTable extends Table {
  TextColumn get id => text().unique()();
  TextColumn get accountId => text()();
  TextColumn get category => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
}

@DriftDatabase(tables: [AccountsTable, ExpensesTable])
class MyXpensesDatabase extends _$MyXpensesDatabase {
  MyXpensesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        // Create helpful indexes and enable foreign keys on every open.
        // Using IF NOT EXISTS makes this safe across app restarts without
        // requiring a schema bump yet.
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');

          // Index to speed up queries filtering by account and date
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_expenses_account_date ON expenses_table(account_id, date)',
          );

          // Index to speed up date range scans and aggregations by date
          await customStatement(
            'CREATE INDEX IF NOT EXISTS idx_expenses_date ON expenses_table(date)',
          );
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'myxpenses.sqlite'));

    // work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
