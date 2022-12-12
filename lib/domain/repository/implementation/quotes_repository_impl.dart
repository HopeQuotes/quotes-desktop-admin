import 'dart:convert';

import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/mappers/ui/quote_mapper.dart';
import 'package:admin/domain/models/request/set_quote_state_request.dart';
import 'package:admin/domain/models/response/quote_response.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/models/ui/quote.dart';
import 'package:admin/domain/repository/abstraction/quotes_repository.dart';

import '../../models/base/base_response.dart';
import '../../models/response/quote_states_response.dart';

class QuotesRepositoryImpl extends QuotesRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> getQuotes(int page) async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/quotes?page=$page');
      var decoded = BaseResponse<QuotesResponse>.fromJson(
          jsonDecode(response.data), (p0) => QuotesResponse.fromJson(p0));

      yield DomainSuccess<List<Quote>>(
          data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      yield DomainError(message: 'Something went wrong...');
    }
  }

  QuotesRepositoryImpl({
    required DioClient client,
  }) : _client = client;

  @override
  Stream<DomainResult> getQuoteStates() async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/quote/states');
      var decoded = BaseResponse<QuoteStatesResponse>.fromJson(
          jsonDecode(response.data), (p0) => QuoteStatesResponse.fromJson(p0));

      yield DomainSuccess<List<QuoteState>>(
          data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      yield DomainError(message: 'Something went wrong...');
    }
  }

  @override
  Stream<DomainResult> setQuoteState(String stateId, String quoteId) async* {
    try {
      yield DomainLoading();
      var response = await _client.patch('/v1/quote/set-state',
          data: SetQuoteStateRequest(id: quoteId, stateId: stateId).toJson());
      if (response.isSuccessful)
        yield DomainSuccess();
      else
        yield DomainError();
    } catch (e) {
      yield DomainError(message: 'Something went wrong...');
    }
  }
}
