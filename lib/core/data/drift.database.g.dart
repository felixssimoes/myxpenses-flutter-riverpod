// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift.database.dart';

// ignore_for_file: type=lint
class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, AccountsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts_table';
  @override
  VerificationContext validateIntegrity(Insertable<AccountsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AccountsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }
}

class AccountsTableData extends DataClass
    implements Insertable<AccountsTableData> {
  final String id;
  final String name;
  const AccountsTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory AccountsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  AccountsTableData copyWith({String? id, String? name}) => AccountsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  AccountsTableData copyWithCompanion(AccountsTableCompanion data) {
    return AccountsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountsTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class AccountsTableCompanion extends UpdateCompanion<AccountsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<AccountsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsTableCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, accountId, category, date, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpensesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableData extends DataClass
    implements Insertable<ExpensesTableData> {
  final String id;
  final String accountId;
  final String category;
  final DateTime date;
  final double amount;
  const ExpensesTableData(
      {required this.id,
      required this.accountId,
      required this.category,
      required this.date,
      required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['category'] = Variable<String>(category);
    map['date'] = Variable<DateTime>(date);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      category: Value(category),
      date: Value(date),
      amount: Value(amount),
    );
  }

  factory ExpensesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      category: serializer.fromJson<String>(json['category']),
      date: serializer.fromJson<DateTime>(json['date']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'category': serializer.toJson<String>(category),
      'date': serializer.toJson<DateTime>(date),
      'amount': serializer.toJson<double>(amount),
    };
  }

  ExpensesTableData copyWith(
          {String? id,
          String? accountId,
          String? category,
          DateTime? date,
          double? amount}) =>
      ExpensesTableData(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        category: category ?? this.category,
        date: date ?? this.date,
        amount: amount ?? this.amount,
      );
  ExpensesTableData copyWithCompanion(ExpensesTableCompanion data) {
    return ExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      category: data.category.present ? data.category.value : this.category,
      date: data.date.present ? data.date.value : this.date,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, category, date, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.category == this.category &&
          other.date == this.date &&
          other.amount == this.amount);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> category;
  final Value<DateTime> date;
  final Value<double> amount;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.category = const Value.absent(),
    this.date = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String accountId,
    required String category,
    required DateTime date,
    required double amount,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        accountId = Value(accountId),
        category = Value(category),
        date = Value(date),
        amount = Value(amount);
  static Insertable<ExpensesTableData> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? category,
    Expression<DateTime>? date,
    Expression<double>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (category != null) 'category': category,
      if (date != null) 'date': date,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? accountId,
      Value<String>? category,
      Value<DateTime>? date,
      Value<double>? amount,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      category: category ?? this.category,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('category: $category, ')
          ..write('date: $date, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyXpensesDatabase extends GeneratedDatabase {
  _$MyXpensesDatabase(QueryExecutor e) : super(e);
  $MyXpensesDatabaseManager get managers => $MyXpensesDatabaseManager(this);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [accountsTable, expensesTable];
}

typedef $$AccountsTableTableCreateCompanionBuilder = AccountsTableCompanion
    Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$AccountsTableTableUpdateCompanionBuilder = AccountsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

class $$AccountsTableTableFilterComposer
    extends Composer<_$MyXpensesDatabase, $AccountsTableTable> {
  $$AccountsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$AccountsTableTableOrderingComposer
    extends Composer<_$MyXpensesDatabase, $AccountsTableTable> {
  $$AccountsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableTableAnnotationComposer
    extends Composer<_$MyXpensesDatabase, $AccountsTableTable> {
  $$AccountsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$AccountsTableTableTableManager extends RootTableManager<
    _$MyXpensesDatabase,
    $AccountsTableTable,
    AccountsTableData,
    $$AccountsTableTableFilterComposer,
    $$AccountsTableTableOrderingComposer,
    $$AccountsTableTableAnnotationComposer,
    $$AccountsTableTableCreateCompanionBuilder,
    $$AccountsTableTableUpdateCompanionBuilder,
    (
      AccountsTableData,
      BaseReferences<_$MyXpensesDatabase, $AccountsTableTable,
          AccountsTableData>
    ),
    AccountsTableData,
    PrefetchHooks Function()> {
  $$AccountsTableTableTableManager(
      _$MyXpensesDatabase db, $AccountsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsTableCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsTableCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AccountsTableTableProcessedTableManager = ProcessedTableManager<
    _$MyXpensesDatabase,
    $AccountsTableTable,
    AccountsTableData,
    $$AccountsTableTableFilterComposer,
    $$AccountsTableTableOrderingComposer,
    $$AccountsTableTableAnnotationComposer,
    $$AccountsTableTableCreateCompanionBuilder,
    $$AccountsTableTableUpdateCompanionBuilder,
    (
      AccountsTableData,
      BaseReferences<_$MyXpensesDatabase, $AccountsTableTable,
          AccountsTableData>
    ),
    AccountsTableData,
    PrefetchHooks Function()>;
typedef $$ExpensesTableTableCreateCompanionBuilder = ExpensesTableCompanion
    Function({
  required String id,
  required String accountId,
  required String category,
  required DateTime date,
  required double amount,
  Value<int> rowid,
});
typedef $$ExpensesTableTableUpdateCompanionBuilder = ExpensesTableCompanion
    Function({
  Value<String> id,
  Value<String> accountId,
  Value<String> category,
  Value<DateTime> date,
  Value<double> amount,
  Value<int> rowid,
});

class $$ExpensesTableTableFilterComposer
    extends Composer<_$MyXpensesDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableTableOrderingComposer
    extends Composer<_$MyXpensesDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId => $composableBuilder(
      column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableTableAnnotationComposer
    extends Composer<_$MyXpensesDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$ExpensesTableTableTableManager extends RootTableManager<
    _$MyXpensesDatabase,
    $ExpensesTableTable,
    ExpensesTableData,
    $$ExpensesTableTableFilterComposer,
    $$ExpensesTableTableOrderingComposer,
    $$ExpensesTableTableAnnotationComposer,
    $$ExpensesTableTableCreateCompanionBuilder,
    $$ExpensesTableTableUpdateCompanionBuilder,
    (
      ExpensesTableData,
      BaseReferences<_$MyXpensesDatabase, $ExpensesTableTable,
          ExpensesTableData>
    ),
    ExpensesTableData,
    PrefetchHooks Function()> {
  $$ExpensesTableTableTableManager(
      _$MyXpensesDatabase db, $ExpensesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> accountId = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion(
            id: id,
            accountId: accountId,
            category: category,
            date: date,
            amount: amount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String accountId,
            required String category,
            required DateTime date,
            required double amount,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion.insert(
            id: id,
            accountId: accountId,
            category: category,
            date: date,
            amount: amount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableTableProcessedTableManager = ProcessedTableManager<
    _$MyXpensesDatabase,
    $ExpensesTableTable,
    ExpensesTableData,
    $$ExpensesTableTableFilterComposer,
    $$ExpensesTableTableOrderingComposer,
    $$ExpensesTableTableAnnotationComposer,
    $$ExpensesTableTableCreateCompanionBuilder,
    $$ExpensesTableTableUpdateCompanionBuilder,
    (
      ExpensesTableData,
      BaseReferences<_$MyXpensesDatabase, $ExpensesTableTable,
          ExpensesTableData>
    ),
    ExpensesTableData,
    PrefetchHooks Function()>;

class $MyXpensesDatabaseManager {
  final _$MyXpensesDatabase _db;
  $MyXpensesDatabaseManager(this._db);
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db, _db.accountsTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$databaseHash() => r'ad17d18014aa1991f02320af70397b9cdaa16354';

/// See also [database].
@ProviderFor(database)
final databaseProvider = Provider<MyXpensesDatabase>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = ProviderRef<MyXpensesDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
