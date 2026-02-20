// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses.notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$expensesHash() => r'7bd62e790ea8c46416bbcf67cc15adee8217259c';

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
    String? category,
  }) {
    return ExpensesProvider(
      accountId: accountId,
      category: category,
    );
  }

  @override
  ExpensesProvider getProviderOverride(
    covariant ExpensesProvider provider,
  ) {
    return call(
      accountId: provider.accountId,
      category: provider.category,
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
class ExpensesProvider extends AutoDisposeFutureProvider<List<ExpenseModel>> {
  /// See also [expenses].
  ExpensesProvider({
    required String accountId,
    String? category,
  }) : this._internal(
          (ref) => expenses(
            ref as ExpensesRef,
            accountId: accountId,
            category: category,
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
          category: category,
        );

  ExpensesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
    required this.category,
  }) : super.internal();

  final String accountId;
  final String? category;

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
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExpenseModel>> createElement() {
    return _ExpensesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpensesProvider &&
        other.accountId == accountId &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpensesRef on AutoDisposeFutureProviderRef<List<ExpenseModel>> {
  /// The parameter `accountId` of this provider.
  String get accountId;

  /// The parameter `category` of this provider.
  String? get category;
}

class _ExpensesProviderElement
    extends AutoDisposeFutureProviderElement<List<ExpenseModel>>
    with ExpensesRef {
  _ExpensesProviderElement(super.provider);

  @override
  String get accountId => (origin as ExpensesProvider).accountId;
  @override
  String? get category => (origin as ExpensesProvider).category;
}

String _$expenseHash() => r'5787f1bd0c031d3d233047306d40068fe9c7bf74';

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
class ExpenseProvider extends AutoDisposeFutureProvider<ExpenseModel?> {
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
  AutoDisposeFutureProviderElement<ExpenseModel?> createElement() {
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExpenseRef on AutoDisposeFutureProviderRef<ExpenseModel?> {
  /// The parameter `expenseId` of this provider.
  String get expenseId;
}

class _ExpenseProviderElement
    extends AutoDisposeFutureProviderElement<ExpenseModel?> with ExpenseRef {
  _ExpenseProviderElement(super.provider);

  @override
  String get expenseId => (origin as ExpenseProvider).expenseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
