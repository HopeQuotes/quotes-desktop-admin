import 'dart:convert';

import 'package:admin/domain/mappers/ui/id_value_mapper.dart';
import 'package:admin/domain/models/response/hashtags_response.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/repository/abstraction/hashtag_repository.dart';
import 'package:admin/models/id_value.dart';

import '../../../data/api/dio.dart';
import '../../models/base/base_response.dart';
import '../../models/request/create_hashtag_request.dart';

class HashtagRepositoryImpl extends HashtagRepository {
  final HttpClient _client;

  @override
  Stream<DomainResult> createHashtag(String value) async* {
    try {
      yield DomainLoading();
      if (value.trim().isEmpty) {
        yield DomainError(message: 'Malumotlarni oxirigacha toldiring.');
      } else {
        var response = await _client.post('v1/login',
            data: CreateHashtagRequest(value: value).toJson());

        if (response.isSuccessful) yield DomainSuccess();
      }
    } catch (e) {
      yield DomainError(message: 'Nomalum xatolik yuz berdi');
    }
  }

  @override
  Stream<DomainResult> getHashtags(int page) async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/hashtags&page=$page');
      var decoded = BaseResponse<HashtagsResponse>.fromJson(
          jsonDecode(response.data), (p0) => HashtagsResponse.fromJson(p0));

      yield DomainSuccess<List<IdValue>>(
          data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      yield DomainError(message: 'Nomalum xatolik yuz berdi');
    }
  }

  HashtagRepositoryImpl({
    required HttpClient client,
  }) : _client = client; //
}
