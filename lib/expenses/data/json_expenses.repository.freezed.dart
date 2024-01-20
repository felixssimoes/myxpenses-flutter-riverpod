// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_expenses.repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

_ExpensesModel _$ExpensesModelFromJson(Map<String, dynamic> json) {
  return __ExpensesModel.fromJson(json);
}

/// @nodoc
mixin _$ExpensesModel {
  List<ExpenseModel> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ExpensesModelCopyWith<_ExpensesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ExpensesModelCopyWith<$Res> {
  factory _$ExpensesModelCopyWith(
          _ExpensesModel value, $Res Function(_ExpensesModel) then) =
      __$ExpensesModelCopyWithImpl<$Res, _ExpensesModel>;
  @useResult
  $Res call({List<ExpenseModel> items});
}

/// @nodoc
class __$ExpensesModelCopyWithImpl<$Res, $Val extends _ExpensesModel>
    implements _$ExpensesModelCopyWith<$Res> {
  __$ExpensesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExpensesModelImplCopyWith<$Res>
    implements _$ExpensesModelCopyWith<$Res> {
  factory _$$_ExpensesModelImplCopyWith(_$_ExpensesModelImpl value,
          $Res Function(_$_ExpensesModelImpl) then) =
      __$$_ExpensesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ExpenseModel> items});
}

/// @nodoc
class __$$_ExpensesModelImplCopyWithImpl<$Res>
    extends __$ExpensesModelCopyWithImpl<$Res, _$_ExpensesModelImpl>
    implements _$$_ExpensesModelImplCopyWith<$Res> {
  __$$_ExpensesModelImplCopyWithImpl(
      _$_ExpensesModelImpl _value, $Res Function(_$_ExpensesModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$_ExpensesModelImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ExpenseModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpensesModelImpl implements __ExpensesModel {
  const _$_ExpensesModelImpl({required final List<ExpenseModel> items})
      : _items = items;

  factory _$_ExpensesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$_ExpensesModelImplFromJson(json);

  final List<ExpenseModel> _items;
  @override
  List<ExpenseModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return '_ExpensesModel(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpensesModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpensesModelImplCopyWith<_$_ExpensesModelImpl> get copyWith =>
      __$$_ExpensesModelImplCopyWithImpl<_$_ExpensesModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpensesModelImplToJson(
      this,
    );
  }
}

abstract class __ExpensesModel implements _ExpensesModel {
  const factory __ExpensesModel({required final List<ExpenseModel> items}) =
      _$_ExpensesModelImpl;

  factory __ExpensesModel.fromJson(Map<String, dynamic> json) =
      _$_ExpensesModelImpl.fromJson;

  @override
  List<ExpenseModel> get items;
  @override
  @JsonKey(ignore: true)
  _$$_ExpensesModelImplCopyWith<_$_ExpensesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
