import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/mappers/ui/id_value_mapper.dart';
import 'package:admin/domain/mappers/ui/image_mapper.dart';
import 'package:admin/domain/models/request/create_quote_request.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/models/ui/image.dart';
import 'package:admin/domain/models/ui/quote.dart';
import 'package:admin/domain/repository/abstraction/quote_repository.dart';
import 'package:flutter/scheduler.dart';

import '../../models/base/base_response.dart';
import '../../models/response/hashtags_response.dart';
import '../../models/response/image_response.dart';
import '../../models/ui/id_value.dart';

class CreateQuoteRepositoryImpl extends QuoteRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> createQuote(String author, String body,
      List<String> hashtags, String photoId) async* {
    try {
      yield DomainLoading();
      print(author);
      print(body);
      print(hashtags);
      print(photoId);
      if (author.trim().isEmpty || body.isEmpty || hashtags.isEmpty) {
        yield DomainError(message: 'Заполните все данные !');
      } else if (photoId.isEmpty) {
        yield DomainError(message: 'Выберите рисунок !');
      } else {
        var response = await _client.post('v1/quote',
            data: CreateQuoteRequest(
                    author: author.trim(),
                    text: body.trim(),
                    hashtagIds: hashtags,
                    photoId: photoId)
                .toJson());
        if (response.statusCode == 200) {
          yield DomainSuccess(message: "Цитата успешно создана !");
        } else {
          yield DomainError(message: 'Что то пошло не так...');
        }
      }
    } catch (e) {
      yield DomainError(message: "Что то пошло не так");
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
      yield DomainError(message: 'Что то пошло не так...');
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

  @override
  Stream<DomainResult> getImages() async* {
    try {
      yield DomainLoading();
      var response = await _client.get('v1/photos');
      var decoded = BaseResponse<ImagesResponse>.fromJson(
          jsonDecode(response.data), (p0) => ImagesResponse.fromJson(p0));

      yield DomainSuccess<List<QuoteImage>>(
          data: decoded.data.data.map((e) => e.toUi()).toList());
    } catch (e) {
      print(e);
      yield DomainError(message: 'Что то пошло не так...');
    }
  }

  CreateQuoteRepositoryImpl({
    required DioClient client,
  }) : _client = client;

  @override
  Stream<DomainResult> createQuotes(String author, List<IdValue> hashtags,
      String photoId, List<String> contents) async* {
    try {
      yield DomainLoading(message: "Подготовка к отправке...");
      if (author.trim().isEmpty || contents.isEmpty || hashtags.isEmpty) {
        yield DomainError(message: 'Заполните все данные !');
      } else if (photoId.isEmpty) {
        yield DomainError(message: 'Выберите рисунок !');
      } else {
        await Future.delayed(Duration(seconds: 2));
        yield DomainLoading(message: "Отправка началось...");
        var synced = 0;
        for(int i = 0; i < contents.length; i++) {
          await Future.delayed(Duration(seconds: 3));
          await _client.post('v1/quote',
              data: CreateQuoteRequest(
                  author: author.trim(),
                  text: contents[i].trim(),
                  hashtagIds: hashtags.map((e) => e.id).toList(),
                  photoId: photoId)
                  .toJson());
          synced++;
          yield DomainLoading(message: "Отправлено $synced из ${contents.length}");
        }
        yield DomainSuccess();
      }
    } catch (e) {
      yield DomainError(message: 'Что то пошло не так...');
    }
  }

  @override
  Stream<DomainResult> analyzeQuotesFile(String path, String splitBy) async* {
    var file = File(path);
    var content = await file.readAsString();
    print(content);
    var splitted = content.split(splitBy);
    yield DomainSuccess(data: splitted);
  }
}
