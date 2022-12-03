import 'dart:convert';

import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/models/response/quote_response.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/quotes_repository.dart';

import '../../../models/id_value.dart';
import '../../models/base/base_response.dart';

class QuotesRepositoryImpl extends QuotesRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> getQuotes(int page) async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/quotes?page=$page');
      var decoded = BaseResponse<QuotesResponse>.fromJson(
          jsonDecode(response.data), (p0) => QuotesResponse.fromJson(p0));
      //
      // yield DomainSuccess<List<IdValue>>(
      //     data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      yield DomainError(message: 'Something went wrong...');
    }
  }

  QuotesRepositoryImpl({
    required DioClient client,
  }) : _client = client;
}
