import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/domain/models/ui/id_value.dart';
import 'package:admin/domain/models/ui/quote.dart';
import 'package:admin/utils/array.dart';
import 'package:admin/utils/controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/ui/image.dart';
import '../../../../domain/repository/abstraction/quote_repository.dart';

part 'create_quote_event.dart';
part 'create_quote_state.dart';

class CreateQuoteBloc extends Bloc<CreateQuoteEvent, CreateQuoteState> {
  final QuoteRepository _repository;
  final TextEditingController authorController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final ScrollController hashtagScrollController = ScrollController();
  int page = 1;
  var endOfPaginationReached = false;

  CreateQuoteBloc(this._repository) : super(CreateQuoteState()) {
    on<CreateQuote>(_createQuote);
    on<CreateQuotes>(_createQuotes);
    on<RemoveHashTag>(_deleteHashtag);
    on<RemoveText>(_deleteText);
    on<AddHashTag>(_addHashtag);
    on<LoadHashTags>(_loadHashtags);
    on<LoadImages>(_loadImages);
    on<SetSelectedState>(_setSelectedState);
    on<LoadStates>(_loadQuoteStates);
    on<SetSelectedImageId>(_setSelectedImage);
    on<AnalyzeFile>(_analyzeFile);

    hashtagScrollController.onBottomReached(() {
      if (!endOfPaginationReached) {
        page++;
        add(LoadHashTags());
      }
    });
  }

  Future<void> _setSelectedImage(
      SetSelectedImageId event, Emitter emitter) async {
    return emitter(state.copyWith(selectedImageId: event.id));
  }

  Future<void> _setSelectedState(
      SetSelectedState event, Emitter emitter) async {
    return emitter(state.copyWith(selectedQuoteState: event.state));
  }

  Future<void> _analyzeFile(AnalyzeFile event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.analyzeQuotesFile(event.path, event.splitBy),
        onData: (data) {
      if (data is DomainSuccess<List<String>>) {
        return state.copyWith(fileContent: data.data?.map((e) => Content(value: e)).toList());
      }
      return state;
    });
  }

  Future<void> _deleteHashtag(RemoveHashTag event, Emitter emitter) async {
    state.userHashtags
        ?.removeWhere((element) => element.value == event.hashtag.value);

    return emitter(state.copyWith(userHashtags: state.userHashtags));
  }

  Future<void> _deleteText(RemoveText event, Emitter emitter) async {
    state.fileContent?.remove(event.text);
    return emitter(state.copyWith(fileContent: state.fileContent,message: "${event.text.value.trim().ellipsize(50)} удален"));
  }

  Future<void> _addHashtag(AddHashTag event, Emitter emitter) async {
    var exist = (state.userHashtags ?? [])
        .where((element) => element.value == event.hashtag.value)
        .toList()
        .isNotEmpty;
    if (!exist) {
      return emitter(state.copyWith(
          userHashtags: (state.userHashtags ?? []) + [event.hashtag]));
    }
  }

  Future<void> _createQuote(CreateQuote event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.createQuote(
            authorController.text,
            bodyController.text,
            (state.userHashtags ?? []).map((e) => e.id).toList(),
            state.selectedImageId ?? "",
            state.selectedQuoteState?.id ?? ""), onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.success,
            message: data.message);
      }
      if (data is DomainError) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.fail, message: data.message);
      }
      if (data is DomainLoading) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.loading,
            message: "Creating quote...");
      }
      return state;
    });
  }

  Future<void> _createQuotes(CreateQuotes event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.createQuotes(
            authorController.text,
            state.userHashtags ?? [],
            state.selectedImageId ?? "",
            state.fileContent?.map((e) => e.value).toList() ?? [],
            state.selectedQuoteState?.id ?? ""), onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.success,
            message: data.message);
      }
      if (data is DomainError) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.fail, message: data.message);
      }
      if (data is DomainLoading) {
        return state.copyWith(
            createQuoteStatus: CreateQuoteStatus.loading,
            message: data.message);
      }
      return state;
    });
  }

  Future<void> _loadHashtags(LoadHashTags event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getHashtags(page),
        onData: (data) {
      if (data is DomainLoading) {
        return state.copyWith(
            hashTagPagingStatus: (state.hashtags ?? []).isEmpty == true
                ? HashTagPagingStatus.initialPaging
                : HashTagPagingStatus.pagingLoading);
      }
      if (data is DomainSuccess<List<IdValue>>) {
        endOfPaginationReached = (data.data ?? []).length < 20;
        return state.copyWith(
            hashTagPagingStatus: HashTagPagingStatus.successPaging,
            hashtags: (state.hashtags ?? []) + (data.data ?? []));
      }
      if (data is DomainError) {
        return state.copyWith(
            hashTagPagingStatus: HashTagPagingStatus.failPaging);
      }
      return state;
    });
  }

  Future<void> _loadQuoteStates(LoadStates event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getQuoteStates(),
        onData: (data) {
      if (data is DomainSuccess<List<QuoteState>>) {
        return state.copyWith(quoteStates: data.data);
      }
      return state;
    });
  }

  Future<void> _loadImages(LoadImages event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getImages(),
        onData: (data) {
      if (data is DomainLoading) {
        return state.copyWith(imageStatus: ImageStatus.loading);
      }
      if (data is DomainSuccess<List<QuoteImage>>) {
        return state.copyWith(
            imageStatus: ImageStatus.success,
            images: (state.images ?? []) + (data.data ?? []));
      }
      if (data is DomainError) {
        return state.copyWith(
            imageStatus: ImageStatus.fail, message: data.message);
      }
      return state;
    });
  }
}
