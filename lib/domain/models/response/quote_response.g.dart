// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    QuoteResponse(
      id: json['id'] as String,
      state: json['state'] as String,
      author: json['author'] as String,
      text: json['text'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuoteResponseToJson(QuoteResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'author': instance.author,
      'text': instance.text,
      'hashtags': instance.hashtags,
    };
