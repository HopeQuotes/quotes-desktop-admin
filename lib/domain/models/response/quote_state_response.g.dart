// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteStateResponse _$QuoteStateResponseFromJson(Map<String, dynamic> json) =>
    QuoteStateResponse(
      id: json['id'] as String,
      value: json['value'] as String,
      idDefault: json['idDefault'] as bool,
    );

Map<String, dynamic> _$QuoteStateResponseToJson(QuoteStateResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'isDefault': instance.idDefault,
    };
