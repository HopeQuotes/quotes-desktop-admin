import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:admin/data/api/dio.dart';
import 'package:admin/domain/mappers/ui/id_value_mapper.dart';
import 'package:admin/domain/mappers/ui/image_mapper.dart';
import 'package:admin/domain/mappers/ui/quote_mapper.dart';
import 'package:admin/domain/models/request/create_quote_request.dart';
import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/models/ui/image.dart';
import 'package:admin/domain/models/ui/quote.dart';
import 'package:admin/domain/repository/abstraction/quote_repository.dart';
import 'package:flutter/scheduler.dart';

import '../../models/base/base_response.dart';
import '../../models/response/hashtags_response.dart';
import '../../models/response/image_response.dart';
import '../../models/response/quote_states_response.dart';
import '../../models/ui/id_value.dart';

class CreateQuoteRepositoryImpl extends QuoteRepository {
  final DioClient _client;

  @override
  Stream<DomainResult> createQuote(String author, String body,
      List<String> hashtags, String photoId,String stateId) async* {
    try {
      yield DomainLoading();
      print(author);
      print(body);
      print(hashtags);
      print(photoId);
      if (author.trim().isEmpty || body.isEmpty || hashtags.isEmpty || stateId.isEmpty) {
        yield DomainError(message: 'Заполните все данные !');
      } else if (photoId.isEmpty) {
        yield DomainError(message: 'Выберите рисунок !');
      } else {
        var response = await _client.post('v1/quote',
            data: CreateQuoteRequest(
                    author: author.trim(),
                    text: body.trim(),
                    hashtagIds: hashtags,
                    photoId: photoId, stateId: stateId)
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
      List<String> photoIds, List<String> contents,String stateId) async* {
    try {
      var random = Random();
      yield DomainLoading(message: "Подготовка к отправке...");
      if (author.trim().isEmpty || contents.isEmpty || hashtags.isEmpty || stateId.isEmpty) {
        yield DomainError(message: 'Заполните все данные !');
      } else if (photoIds.isEmpty) {
        yield DomainError(message: 'Нужны рисунки для цитаты !');
      } else {
        await Future.delayed(Duration(seconds: 3));
        yield DomainLoading(message: "Отправка началось...");
        var synced = 0;
        var error = 0;
        for (int i = 0; i < contents.length; i++) {
          await Future.delayed(Duration(seconds: 2));
          try {
            await _client.post('v1/quote',
                data: CreateQuoteRequest(
                        author: author.trim(),
                        text: contents[i].trim(),
                        hashtagIds: hashtags.map((e) => e.id).toList(),
                        photoId: photoIds[random.nextInt(photoIds.length - 1)], stateId: stateId)
                    .toJson());
            synced++;
            yield DomainLoading(
                message:
                    "Отправлено $synced из ${contents.length} ошибок $error");
          } catch (e) {
            error++;
          }
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
}
