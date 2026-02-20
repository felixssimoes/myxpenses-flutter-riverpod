// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_summary.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategorySummary {
  String get category;
  double get total;
  int get expenseCount;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategorySummaryCopyWith<CategorySummary> get copyWith =>
      _$CategorySummaryCopyWithImpl<CategorySummary>(
          this as CategorySummary, _$identity);

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategorySummary &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.expenseCount, expenseCount) ||
                other.expenseCount == expenseCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, total, expenseCount);

  @override
  String toString() {
    return 'CategorySummary(category: $category, total: $total, expenseCount: $expenseCount)';
  }
}

/// @nodoc
abstract mixin class $CategorySummaryCopyWith<$Res> {
  factory $CategorySummaryCopyWith(
          CategorySummary value, $Res Function(CategorySummary) _then) =
      _$CategorySummaryCopyWithImpl;
  @useResult
  $Res call({String category, double total, int expenseCount});
}

/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._self, this._then);

  final CategorySummary _self;
  final $Res Function(CategorySummary) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? total = null,
    Object? expenseCount = null,
  }) {
    return _then(_self.copyWith(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      expenseCount: null == expenseCount
          ? _self.expenseCount
          : expenseCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CategorySummary].
extension CategorySummaryPatterns on CategorySummary {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CategorySummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CategorySummary() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_CategorySummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySummary():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CategorySummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySummary() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String category, double total, int expenseCount)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CategorySummary() when $default != null:
        return $default(_that.category, _that.total, _that.expenseCount);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String category, double total, int expenseCount) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySummary():
        return $default(_that.category, _that.total, _that.expenseCount);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String category, double total, int expenseCount)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CategorySummary() when $default != null:
        return $default(_that.category, _that.total, _that.expenseCount);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CategorySummary implements CategorySummary {
  const _CategorySummary(
      {required this.category,
      required this.total,
      required this.expenseCount});
  factory _CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);

  @override
  final String category;
  @override
  final double total;
  @override
  final int expenseCount;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategorySummaryCopyWith<_CategorySummary> get copyWith =>
      __$CategorySummaryCopyWithImpl<_CategorySummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategorySummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategorySummary &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.expenseCount, expenseCount) ||
                other.expenseCount == expenseCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, total, expenseCount);

  @override
  String toString() {
    return 'CategorySummary(category: $category, total: $total, expenseCount: $expenseCount)';
  }
}

/// @nodoc
abstract mixin class _$CategorySummaryCopyWith<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  factory _$CategorySummaryCopyWith(
          _CategorySummary value, $Res Function(_CategorySummary) _then) =
      __$CategorySummaryCopyWithImpl;
  @override
  @useResult
  $Res call({String category, double total, int expenseCount});
}

/// @nodoc
class __$CategorySummaryCopyWithImpl<$Res>
    implements _$CategorySummaryCopyWith<$Res> {
  __$CategorySummaryCopyWithImpl(this._self, this._then);

  final _CategorySummary _self;
  final $Res Function(_CategorySummary) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? total = null,
    Object? expenseCount = null,
  }) {
    return _then(_CategorySummary(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      expenseCount: null == expenseCount
          ? _self.expenseCount
          : expenseCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
