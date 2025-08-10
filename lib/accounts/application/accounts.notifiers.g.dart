// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accountsHash() => r'6f7a623656c3bcc94d101094cd6c8a94de100078';

/// See also [accounts].
@ProviderFor(accounts)
final accountsProvider = FutureProvider<List<AccountModel>>.internal(
  accounts,
  name: r'accountsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccountsRef = FutureProviderRef<List<AccountModel>>;
String _$accountHash() => r'45632baa4a38b0d6d9efb0db6ad786dc88ad6536';

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

/// See also [account].
@ProviderFor(account)
const accountProvider = AccountFamily();

/// See also [account].
class AccountFamily extends Family<AsyncValue<AccountModel?>> {
  /// See also [account].
  const AccountFamily();

  /// See also [account].
  AccountProvider call(
    String accountId,
  ) {
    return AccountProvider(
      accountId,
    );
  }

  @override
  AccountProvider getProviderOverride(
    covariant AccountProvider provider,
  ) {
    return call(
      provider.accountId,
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
  String? get name => r'accountProvider';
}

/// See also [account].
class AccountProvider extends FutureProvider<AccountModel?> {
  /// See also [account].
  AccountProvider(
    String accountId,
  ) : this._internal(
          (ref) => account(
            ref as AccountRef,
            accountId,
          ),
          from: accountProvider,
          name: r'accountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountHash,
          dependencies: AccountFamily._dependencies,
          allTransitiveDependencies: AccountFamily._allTransitiveDependencies,
          accountId: accountId,
        );

  AccountProvider._internal(
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
    FutureOr<AccountModel?> Function(AccountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AccountProvider._internal(
        (ref) => create(ref as AccountRef),
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
  FutureProviderElement<AccountModel?> createElement() {
    return _AccountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountProvider && other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AccountRef on FutureProviderRef<AccountModel?> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _AccountProviderElement extends FutureProviderElement<AccountModel?>
    with AccountRef {
  _AccountProviderElement(super.provider);

  @override
  String get accountId => (origin as AccountProvider).accountId;
}

String _$accountsViewHash() => r'48034beaf7d616ac78157490a94f8cb621a0cda2';

/// See also [accountsView].
@ProviderFor(accountsView)
final accountsViewProvider = FutureProvider<List<AccountView>>.internal(
  accountsView,
  name: r'accountsViewProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountsViewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AccountsViewRef = FutureProviderRef<List<AccountView>>;
String _$accountViewHash() => r'27e23e359ead9e057aa99c4fedb60805cba00bcc';

/// See also [accountView].
@ProviderFor(accountView)
const accountViewProvider = AccountViewFamily();

/// See also [accountView].
class AccountViewFamily extends Family<AsyncValue<AccountView?>> {
  /// See also [accountView].
  const AccountViewFamily();

  /// See also [accountView].
  AccountViewProvider call(
    String accountId,
  ) {
    return AccountViewProvider(
      accountId,
    );
  }

  @override
  AccountViewProvider getProviderOverride(
    covariant AccountViewProvider provider,
  ) {
    return call(
      provider.accountId,
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
  String? get name => r'accountViewProvider';
}

/// See also [accountView].
class AccountViewProvider extends FutureProvider<AccountView?> {
  /// See also [accountView].
  AccountViewProvider(
    String accountId,
  ) : this._internal(
          (ref) => accountView(
            ref as AccountViewRef,
            accountId,
          ),
          from: accountViewProvider,
          name: r'accountViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accountViewHash,
          dependencies: AccountViewFamily._dependencies,
          allTransitiveDependencies:
              AccountViewFamily._allTransitiveDependencies,
          accountId: accountId,
        );

  AccountViewProvider._internal(
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
    FutureOr<AccountView?> Function(AccountViewRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AccountViewProvider._internal(
        (ref) => create(ref as AccountViewRef),
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
  FutureProviderElement<AccountView?> createElement() {
    return _AccountViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccountViewProvider && other.accountId == accountId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AccountViewRef on FutureProviderRef<AccountView?> {
  /// The parameter `accountId` of this provider.
  String get accountId;
}

class _AccountViewProviderElement extends FutureProviderElement<AccountView?>
    with AccountViewRef {
  _AccountViewProviderElement(super.provider);

  @override
  String get accountId => (origin as AccountViewProvider).accountId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
