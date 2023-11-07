// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_accounts.repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AccountsModelImpl _$$_AccountsModelImplFromJson(Map<String, dynamic> json) =>
    _$_AccountsModelImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AccountsModelImplToJson(
        _$_AccountsModelImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
