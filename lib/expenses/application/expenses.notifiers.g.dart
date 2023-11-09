// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expensesHash() => r'60f666f039a322a2f307cd4b1cb6d11dd512809a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [expenses].
@ProviderFor(expenses)
const expensesProvider = ExpensesFamily();

/// See also [expenses].
class ExpensesFamily extends Family<AsyncValue<List<ExpenseModel>>> {
  /// See also [expenses].
  const ExpensesFamily();

  /// See also [expenses].
  ExpensesProvider call({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return ExpensesProvider(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  ExpensesProvider getProviderOverride(
    covariant ExpensesProvider provider,
  ) {
    return call(
      accountId: provider.accountId,
      startDate: provider.startDate,
      endDate: provider.endDate,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'expensesProvider';
}

/// See also [expenses].
class ExpensesProvider extends FutureProvider<List<ExpenseModel>> {
  /// See also [expenses].
  ExpensesProvider({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) : this._internal(
          (ref) => expenses(
            ref as ExpensesRef,
            accountId: accountId,
            startDate: startDate,
            endDate: endDate,
          ),
          from: expensesProvider,
          name: r'expensesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expensesHash,
          dependencies: ExpensesFamily._dependencies,
          allTransitiveDependencies: ExpensesFamily._allTransitiveDependencies,
          accountId: accountId,
          startDate: startDate,
          endDate: endDate,
        );

  ExpensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
    required this.startDate,
    required this.endDate,
  }) : super.internal();

  final String accountId;
  final DateTime startDate;
  final DateTime endDate;

  @override
  Override overrideWith(
    FutureOr<List<ExpenseModel>> Function(ExpensesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpensesProvider._internal(
        (ref) => create(ref as ExpensesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      ),
    );
  }

  @override
  FutureProviderElement<List<ExpenseModel>> createElement() {
    return _ExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesProvider &&
        other.accountId == accountId &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);
    hash = _SystemHash.combine(hash, startDate.hashCode);
    hash = _SystemHash.combine(hash, endDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpensesRef on FutureProviderRef<List<ExpenseModel>> {
  /// The parameter `accountId` of this provider.
  String get accountId;

  /// The parameter `startDate` of this provider.
  DateTime get startDate;

  /// The parameter `endDate` of this provider.
  DateTime get endDate;
}

class _ExpensesProviderElement extends FutureProviderElement<List<ExpenseModel>>
    with ExpensesRef {
  _ExpensesProviderElement(super.provider);

  @override
  String get accountId => (origin as ExpensesProvider).accountId;
  @override
  DateTime get startDate => (origin as ExpensesProvider).startDate;
  @override
  DateTime get endDate => (origin as ExpensesProvider).endDate;
}

String _$allExpensesHash() => r'6788bb477bf7157c4166fe3b4665341fd4657ba0';

/// See also [allExpenses].
@ProviderFor(allExpenses)
const allExpensesProvider = AllExpensesFamily();

/// See also [allExpenses].
class AllExpensesFamily extends Family<AsyncValue<List<ExpenseModel>>> {
  /// See also [allExpenses].
  const AllExpensesFamily();

  /// See also [allExpenses].
  AllExpensesProvider call({
    required String accountId,
  }) {
    return AllExpensesProvider(
      accountId: accountId,
    );
  }

  @override
  AllExpensesProvider getProviderOverride(
    covariant AllExpensesProvider provider,
  ) {
    return call(
      accountId: provider.accountId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'allExpensesProvider';
}

/// See also [allExpenses].
class AllExpensesProvider extends FutureProvider<List<ExpenseModel>> {
  /// See also [allExpenses].
  AllExpensesProvider({
    required String accountId,
  }) : this._internal(
          (ref) => allExpenses(
            ref as AllExpensesRef,
            accountId: accountId,
          ),
          from: allExpensesProvider,
          name: r'allExpensesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allExpensesHash,
          dependencies: AllExpensesFamily._dependencies,
          allTransitiveDependencies:
              AllExpensesFamily._allTransitiveDependencies,
          accountId: accountId,
        );

  AllExpensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
  }) : super.internal();

  final String accountId;

  @override
  Override overrideWith(
    FutureOr<List<ExpenseModel>> Function(AllExpensesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllExpensesProvider._internal(
        (ref) => create(ref as AllExpensesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountId: accountId,
      ),
    );
  }

  @override
  FutureProviderElement<List<ExpenseModel>> createElement() {
    return _AllExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllExpensesProvider && other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AllExpensesRef on FutureProviderRef<List<ExpenseModel>> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _AllExpensesProviderElement
    extends FutureProviderElement<List<ExpenseModel>> with AllExpensesRef {
  _AllExpensesProviderElement(super.provider);

  @override
  String get accountId => (origin as AllExpensesProvider).accountId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
