// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expensesHash() => r'da227338923293bb49c435aeb56159f2b3af1f98';

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
  }) {
    return ExpensesProvider(
      accountId: accountId,
    );
  }

  @override
  ExpensesProvider getProviderOverride(
    covariant ExpensesProvider provider,
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
  String? get name => r'expensesProvider';
}

/// See also [expenses].
class ExpensesProvider extends FutureProvider<List<ExpenseModel>> {
  /// See also [expenses].
  ExpensesProvider({
    required String accountId,
  }) : this._internal(
          (ref) => expenses(
            ref as ExpensesRef,
            accountId: accountId,
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
        );

  ExpensesProvider._internal(
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
      ),
    );
  }

  @override
  FutureProviderElement<List<ExpenseModel>> createElement() {
    return _ExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesProvider && other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpensesRef on FutureProviderRef<List<ExpenseModel>> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _ExpensesProviderElement extends FutureProviderElement<List<ExpenseModel>>
    with ExpensesRef {
  _ExpensesProviderElement(super.provider);

  @override
  String get accountId => (origin as ExpensesProvider).accountId;
}

String _$expenseHash() => r'ae9072124b25266097c7a4c78029b121e520ff94';

/// See also [expense].
@ProviderFor(expense)
const expenseProvider = ExpenseFamily();

/// See also [expense].
class ExpenseFamily extends Family<AsyncValue<ExpenseModel?>> {
  /// See also [expense].
  const ExpenseFamily();

  /// See also [expense].
  ExpenseProvider call({
    required String expenseId,
  }) {
    return ExpenseProvider(
      expenseId: expenseId,
    );
  }

  @override
  ExpenseProvider getProviderOverride(
    covariant ExpenseProvider provider,
  ) {
    return call(
      expenseId: provider.expenseId,
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
  String? get name => r'expenseProvider';
}

/// See also [expense].
class ExpenseProvider extends FutureProvider<ExpenseModel?> {
  /// See also [expense].
  ExpenseProvider({
    required String expenseId,
  }) : this._internal(
          (ref) => expense(
            ref as ExpenseRef,
            expenseId: expenseId,
          ),
          from: expenseProvider,
          name: r'expenseProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expenseHash,
          dependencies: ExpenseFamily._dependencies,
          allTransitiveDependencies: ExpenseFamily._allTransitiveDependencies,
          expenseId: expenseId,
        );

  ExpenseProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expenseId,
  }) : super.internal();

  final String expenseId;

  @override
  Override overrideWith(
    FutureOr<ExpenseModel?> Function(ExpenseRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExpenseProvider._internal(
        (ref) => create(ref as ExpenseRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expenseId: expenseId,
      ),
    );
  }

  @override
  FutureProviderElement<ExpenseModel?> createElement() {
    return _ExpenseProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseProvider && other.expenseId == expenseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expenseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpenseRef on FutureProviderRef<ExpenseModel?> {
  /// The parameter `expenseId` of this provider.
  String get expenseId;
}

class _ExpenseProviderElement extends FutureProviderElement<ExpenseModel?>
    with ExpenseRef {
  _ExpenseProviderElement(super.provider);

  @override
  String get expenseId => (origin as ExpenseProvider).expenseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
