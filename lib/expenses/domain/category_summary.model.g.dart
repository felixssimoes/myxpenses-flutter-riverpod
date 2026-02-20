// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_summary.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) =>
    _CategorySummary(
      category: json['category'] as String,
      total: (json['total'] as num).toDouble(),
      expenseCount: (json['expenseCount'] as num).toInt(),
    );

Map<String, dynamic> _$CategorySummaryToJson(_CategorySummary instance) =>
    <String, dynamic>{
      'category': instance.category,
      'total': instance.total,
      'expenseCount': instance.expenseCount,
    };
