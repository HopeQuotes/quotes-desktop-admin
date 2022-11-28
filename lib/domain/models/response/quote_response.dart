import 'package:json_annotation/json_annotation.dart';

part 'quote_response.g.dart';

@JsonSerializable()
class QuoteResponse {
  String id;
  String state;
  String author;
  String text;
  List<String> hashtags;

  QuoteResponse({
    required this.id,
    required this.state,
    required this.author,
    required this.text,
    required this.hashtags,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);
}
