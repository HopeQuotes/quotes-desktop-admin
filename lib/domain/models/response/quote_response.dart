import 'package:admin/domain/models/id_value_data_response.dart';
import 'package:admin/domain/models/response/quote_state_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_response.g.dart';

@JsonSerializable()
class QuotesResponse {
  List<QuoteResponse> data;

  QuotesResponse({
    required this.data,
  });

  factory QuotesResponse.fromJson(Map<String, dynamic> json) =>
      _$QuotesResponseFromJson(json);
}

@JsonSerializable()
class QuoteResponse {
  String id;
  QuoteStateResponse state;
  String author;
  String text;
  List<IdValueDataResponse> hashtags;

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
