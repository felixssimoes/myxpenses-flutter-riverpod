// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_expenses.repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpensesModelImpl _$$_ExpensesModelImplFromJson(Map<String, dynamic> json) =>
    _$_ExpensesModelImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ExpensesModelImplToJson(
        _$_ExpensesModelImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
