import 'dart:convert';

import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/mappers/ui/id_value_mapper.dart';
import 'package:admin/domain/models/request/create_quote_request.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/create_quote_repository.dart';

import '../../../models/id_value.dart';
import '../../models/base/base_response.dart';
import '../../models/response/hashtags_response.dart';

class CreateQuoteRepositoryImpl extends QuoteRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> createQuote(
      String author, String body, List<String> hashtags) async* {
    try {
      yield DomainLoading();
      if (author.trim().isEmpty || body.isEmpty || hashtags.isEmpty) {
        yield DomainError(message: 'Malumotlarni oxirigacha toldiring !');
      } else {
        var response = await _client.post('quote/create',
            data: CreateQuoteRequest(
                    author: author, text: body, hashtagIds: hashtags)
                .toJson());
        if (response.statusCode == 200) {
          yield DomainSuccess(message: "Quote created !");
        } else {
          yield DomainError(message: 'Xatolik yuz berdi...');
        }
      }
    } catch (e) {
      yield DomainError();
    }
  }

  @override
  Stream<DomainResult> getHashtags(int page) async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/hashtags?page=$page');
      var decoded = BaseResponse<HashtagsResponse>.fromJson(
          jsonDecode(response.data), (p0) => HashtagsResponse.fromJson(p0));

      yield DomainSuccess<List<IdValue>>(
          data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      yield DomainError(message: 'Something went wrong...');
    }
  }

  @override
  Stream<DomainResult> deleteQuote() {
    // TODO: implement deleteQuote
    throw UnimplementedError();
  }

  @override
  Stream<DomainResult> getQuotes(int page) {
    // TODO: implement getQuotes
    throw UnimplementedError();
  }

  CreateQuoteRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
