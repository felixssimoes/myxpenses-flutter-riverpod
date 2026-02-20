// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_summaries.notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categorySummariesHash() => r'3ea75f0b1d9c113c0503de9722f78cd14378806f';

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

/// See also [categorySummaries].
@ProviderFor(categorySummaries)
const categorySummariesProvider = CategorySummariesFamily();

/// See also [categorySummaries].
class CategorySummariesFamily
    extends Family<AsyncValue<List<CategorySummary>>> {
  /// See also [categorySummaries].
  const CategorySummariesFamily();

  /// See also [categorySummaries].
  CategorySummariesProvider call({
    required String accountId,
    required ({
      DateTime endDate,
      DateTime startDate,
      DateIntervalType type
    }) dateInterval,
  }) {
    return CategorySummariesProvider(
      accountId: accountId,
      dateInterval: dateInterval,
    );
  }

  @override
  CategorySummariesProvider getProviderOverride(
    covariant CategorySummariesProvider provider,
  ) {
    return call(
      accountId: provider.accountId,
      dateInterval: provider.dateInterval,
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
  String? get name => r'categorySummariesProvider';
}

/// See also [categorySummaries].
class CategorySummariesProvider
    extends AutoDisposeFutureProvider<List<CategorySummary>> {
  /// See also [categorySummaries].
  CategorySummariesProvider({
    required String accountId,
    required ({
      DateTime endDate,
      DateTime startDate,
      DateIntervalType type
    }) dateInterval,
  }) : this._internal(
          (ref) => categorySummaries(
            ref as CategorySummariesRef,
            accountId: accountId,
            dateInterval: dateInterval,
          ),
          from: categorySummariesProvider,
          name: r'categorySummariesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categorySummariesHash,
          dependencies: CategorySummariesFamily._dependencies,
          allTransitiveDependencies:
              CategorySummariesFamily._allTransitiveDependencies,
          accountId: accountId,
          dateInterval: dateInterval,
        );

  CategorySummariesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountId,
    required this.dateInterval,
  }) : super.internal();

  final String accountId;
  final ({
    DateTime endDate,
    DateTime startDate,
    DateIntervalType type
  }) dateInterval;

  @override
  Override overrideWith(
    FutureOr<List<CategorySummary>> Function(CategorySummariesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategorySummariesProvider._internal(
        (ref) => create(ref as CategorySummariesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountId: accountId,
        dateInterval: dateInterval,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CategorySummary>> createElement() {
    return _CategorySummariesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategorySummariesProvider &&
        other.accountId == accountId &&
        other.dateInterval == dateInterval;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountId.hashCode);
    hash = _SystemHash.combine(hash, dateInterval.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategorySummariesRef
    on AutoDisposeFutureProviderRef<List<CategorySummary>> {
  /// The parameter `accountId` of this provider.
  String get accountId;

  /// The parameter `dateInterval` of this provider.
  ({DateTime endDate, DateTime startDate, DateIntervalType type})
      get dateInterval;
}

class _CategorySummariesProviderElement
    extends AutoDisposeFutureProviderElement<List<CategorySummary>>
    with CategorySummariesRef {
  _CategorySummariesProviderElement(super.provider);

  @override
  String get accountId => (origin as CategorySummariesProvider).accountId;
  @override
  ({DateTime endDate, DateTime startDate, DateIntervalType type})
      get dateInterval => (origin as CategorySummariesProvider).dateInterval;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
