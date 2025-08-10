// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) =>
    _ExpenseModel(
      id: json['id'] as String,
      accountId: json['accountId'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$ExpenseModelToJson(_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'category': instance.category,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
    };
