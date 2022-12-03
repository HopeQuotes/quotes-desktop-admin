import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/models/id_value.dart';
import 'package:admin/utils/controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repository/abstraction/create_quote_repository.dart';

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
    on<RemoteHashTag>(_deleteHashtag);
    on<AddHashTag>(_addHashtag);
    on<LoadHashTags>(_loadHashtags);

    hashtagScrollController.onBottomReached(() {
      if (!endOfPaginationReached) {
        page++;
        add(LoadHashTags());
      }
    });
  }

  Future<void> _deleteHashtag(RemoteHashTag event, Emitter emitter) async {
    state.userHashtags
        ?.removeWhere((element) => element.value == event.hashtag.value);

    return emitter(state.copyWith(userHashtags: state.userHashtags));
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
        _repository.createQuote(authorController.text, bodyController.text,
            (state.userHashtags ?? []).map((e) => e.id).toList()),
        onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(
            status: CreateQuoteStatus.success, message: data.message);
      }
      if (data is DomainError) {
        return state.copyWith(
            status: CreateQuoteStatus.fail, message: data.message);
      }
      if (data is DomainLoading) {
        return state.copyWith(status: CreateQuoteStatus.loading);
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
}
