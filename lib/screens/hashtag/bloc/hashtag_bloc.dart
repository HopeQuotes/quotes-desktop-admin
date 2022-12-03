import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/models/id_value.dart';
import 'package:admin/utils/controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/repository/abstraction/hashtag_repository.dart';
import 'hashtag_event.dart';
import 'hashtag_state.dart';

class HashtagBloc extends Bloc<HashtagEvent, HashtagState> {
  final HashtagRepository _repository;
  final TextEditingController hashTagValueController = TextEditingController();
  final ScrollController hashtagScrollController = ScrollController();
  int page = 1;
  var endOfPaginationReached = false;

  HashtagBloc(this._repository) : super(HashtagState()) {
    on<CreateHashtag>(_createHashTag);
    on<LoadHashTags>(_loadHashtags);

    hashtagScrollController.onBottomReached(() {
      if (!endOfPaginationReached) {
        page++;
        add(LoadHashTags());
      }
    });
  }

  Future<void> _createHashTag(CreateHashtag event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.createHashtag(hashTagValueController.text), onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(
            createStatus: HashTagCreateStatus.success,
            createHashtagMessage: data.message);
      } else if (data is DomainLoading) {
        return state.copyWith(createStatus: HashTagCreateStatus.loading);
      } else {
        return state.copyWith(
            createStatus: HashTagCreateStatus.fail,
            createHashtagMessage: (data as DomainError).message);
      }
    });
  }

  Future<void> _loadHashtags(LoadHashTags event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getHashtags(page),
        onData: (data) {
      if (data is DomainLoading) {
        return state.copyWith(
            hashTagPagingStatus: (state.hashtags ?? []).isEmpty
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
      return state.copyWith(
          hashTagPagingStatus: HashTagPagingStatus.pagingLoading);
    });
  }
}
