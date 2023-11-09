// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_expense.controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateExpenseState {
  String get accountId => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateExpenseStateCopyWith<CreateExpenseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateExpenseStateCopyWith<$Res> {
  factory $CreateExpenseStateCopyWith(
          CreateExpenseState value, $Res Function(CreateExpenseState) then) =
      _$CreateExpenseStateCopyWithImpl<$Res, CreateExpenseState>;
  @useResult
  $Res call(
      {String accountId, String? category, double? amount, DateTime? date});
}

/// @nodoc
class _$CreateExpenseStateCopyWithImpl<$Res, $Val extends CreateExpenseState>
    implements $CreateExpenseStateCopyWith<$Res> {
  _$CreateExpenseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? category = freezed,
    Object? amount = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateExpenseStateImplCopyWith<$Res>
    implements $CreateExpenseStateCopyWith<$Res> {
  factory _$$CreateExpenseStateImplCopyWith(_$CreateExpenseStateImpl value,
          $Res Function(_$CreateExpenseStateImpl) then) =
      __$$CreateExpenseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accountId, String? category, double? amount, DateTime? date});
}

/// @nodoc
class __$$CreateExpenseStateImplCopyWithImpl<$Res>
    extends _$CreateExpenseStateCopyWithImpl<$Res, _$CreateExpenseStateImpl>
    implements _$$CreateExpenseStateImplCopyWith<$Res> {
  __$$CreateExpenseStateImplCopyWithImpl(_$CreateExpenseStateImpl _value,
      $Res Function(_$CreateExpenseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? category = freezed,
    Object? amount = freezed,
    Object? date = freezed,
  }) {
    return _then(_$CreateExpenseStateImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$CreateExpenseStateImpl implements _CreateExpenseState {
  const _$CreateExpenseStateImpl(
      {required this.accountId, this.category, this.amount, this.date});

  @override
  final String accountId;
  @override
  final String? category;
  @override
  final double? amount;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'CreateExpenseState(accountId: $accountId, category: $category, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateExpenseStateImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, accountId, category, amount, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateExpenseStateImplCopyWith<_$CreateExpenseStateImpl> get copyWith =>
      __$$CreateExpenseStateImplCopyWithImpl<_$CreateExpenseStateImpl>(
          this, _$identity);
}

abstract class _CreateExpenseState implements CreateExpenseState {
  const factory _CreateExpenseState(
      {required final String accountId,
      final String? category,
      final double? amount,
      final DateTime? date}) = _$CreateExpenseStateImpl;

  @override
  String get accountId;
  @override
  String? get category;
  @override
  double? get amount;
  @override
  DateTime? get date;
  @override
  @JsonKey(ignore: true)
  _$$CreateExpenseStateImplCopyWith<_$CreateExpenseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
