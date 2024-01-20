// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_expense.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createExpenseControllerHash() =>
    r'50677be322d332f5c59c9b88fdb52f02f55e2b67';

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

abstract class _$CreateExpenseController
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String accountId;

  FutureOr<void> build({
    required String accountId,
  });
}

/// See also [CreateExpenseController].
@ProviderFor(CreateExpenseController)
const createExpenseControllerProvider = CreateExpenseControllerFamily();

/// See also [CreateExpenseController].
class CreateExpenseControllerFamily extends Family<AsyncValue<void>> {
  /// See also [CreateExpenseController].
  const CreateExpenseControllerFamily();

  /// See also [CreateExpenseController].
  CreateExpenseControllerProvider call({
    required String accountId,
  }) {
    return CreateExpenseControllerProvider(
      accountId: accountId,
    );
  }

  @override
  CreateExpenseControllerProvider getProviderOverride(
    covariant CreateExpenseControllerProvider provider,
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
  String? get name => r'createExpenseControllerProvider';
}

/// See also [CreateExpenseController].
class CreateExpenseControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CreateExpenseController,
        void> {
  /// See also [CreateExpenseController].
  CreateExpenseControllerProvider({
    required String accountId,
  }) : this._internal(
          () => CreateExpenseController()..accountId = accountId,
          from: createExpenseControllerProvider,
          name: r'createExpenseControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createExpenseControllerHash,
          dependencies: CreateExpenseControllerFamily._dependencies,
          allTransitiveDependencies:
              CreateExpenseControllerFamily._allTransitiveDependencies,
          accountId: accountId,
        );

  CreateExpenseControllerProvider._internal(
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
  FutureOr<void> runNotifierBuild(
    covariant CreateExpenseController notifier,
  ) {
    return notifier.build(
      accountId: accountId,
    );
  }

  @override
  Override overrideWith(CreateExpenseController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateExpenseControllerProvider._internal(
        () => create()..accountId = accountId,
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
  AutoDisposeAsyncNotifierProviderElement<CreateExpenseController, void>
      createElement() {
    return _CreateExpenseControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateExpenseControllerProvider &&
        other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateExpenseControllerRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _CreateExpenseControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CreateExpenseController,
        void> with CreateExpenseControllerRef {
  _CreateExpenseControllerProviderElement(super.provider);

  @override
  String get accountId => (origin as CreateExpenseControllerProvider).accountId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
