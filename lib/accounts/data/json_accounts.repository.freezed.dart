// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_accounts.repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

_AccountsModel _$AccountsModelFromJson(Map<String, dynamic> json) {
  return __AccountsModel.fromJson(json);
}

/// @nodoc
mixin _$AccountsModel {
  List<AccountModel> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AccountsModelCopyWith<_AccountsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AccountsModelCopyWith<$Res> {
  factory _$AccountsModelCopyWith(
          _AccountsModel value, $Res Function(_AccountsModel) then) =
      __$AccountsModelCopyWithImpl<$Res, _AccountsModel>;
  @useResult
  $Res call({List<AccountModel> items});
}

/// @nodoc
class __$AccountsModelCopyWithImpl<$Res, $Val extends _AccountsModel>
    implements _$AccountsModelCopyWith<$Res> {
  __$AccountsModelCopyWithImpl(this._value, this._then);

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
              as List<AccountModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountsModelImplCopyWith<$Res>
    implements _$AccountsModelCopyWith<$Res> {
  factory _$$_AccountsModelImplCopyWith(_$_AccountsModelImpl value,
          $Res Function(_$_AccountsModelImpl) then) =
      __$$_AccountsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AccountModel> items});
}

/// @nodoc
class __$$_AccountsModelImplCopyWithImpl<$Res>
    extends __$AccountsModelCopyWithImpl<$Res, _$_AccountsModelImpl>
    implements _$$_AccountsModelImplCopyWith<$Res> {
  __$$_AccountsModelImplCopyWithImpl(
      _$_AccountsModelImpl _value, $Res Function(_$_AccountsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$_AccountsModelImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<AccountModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AccountsModelImpl implements __AccountsModel {
  const _$_AccountsModelImpl({required final List<AccountModel> items})
      : _items = items;

  factory _$_AccountsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$_AccountsModelImplFromJson(json);

  final List<AccountModel> _items;
  @override
  List<AccountModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return '_AccountsModel(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountsModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountsModelImplCopyWith<_$_AccountsModelImpl> get copyWith =>
      __$$_AccountsModelImplCopyWithImpl<_$_AccountsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AccountsModelImplToJson(
      this,
    );
  }
}

abstract class __AccountsModel implements _AccountsModel {
  const factory __AccountsModel({required final List<AccountModel> items}) =
      _$_AccountsModelImpl;

  factory __AccountsModel.fromJson(Map<String, dynamic> json) =
      _$_AccountsModelImpl.fromJson;

  @override
  List<AccountModel> get items;
  @override
  @JsonKey(ignore: true)
  _$$_AccountsModelImplCopyWith<_$_AccountsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
