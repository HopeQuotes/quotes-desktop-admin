import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/models/id_value.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/abstraction/hashtag_repository.dart';

part 'hashtag_event.dart';

part 'hashtag_state.dart';

class HashtagBloc extends Bloc<HashtagEvent, HashtagState> {
  final HashtagRepository _repository;
  final TextEditingController hashTagValueController = TextEditingController();
  int page = 1;
  var endOfPaginationReached = false;

  HashtagBloc(this._repository) : super(HashtagState()) {
    on<CreateHashtag>(_createHashTag);
    on<LoadHashTags>(_loadHashtags);
  }

  Future<void> _createHashTag(CreateHashtag event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.createHashtag(hashTagValueController.text), onData: (data) {
      if (data is DomainSuccess) {
        return state.copyWith(createStatus: HashTagCreateStatus.success);
      } else if (data is DomainLoading) {
        return state.copyWith(createStatus: HashTagCreateStatus.loading);
      } else {
        return state.copyWith(createStatus: HashTagCreateStatus.fail);
      }
    });
  }

  Future<void> _loadHashtags(LoadHashTags event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getHashtags(page),
        onData: (data) {
      if (data is DomainSuccess<List<IdValue>>) {
        return state.copyWith(createStatus: HashTagCreateStatus.success);
      } else if (data is DomainLoading) {
        return state.copyWith(createStatus: HashTagCreateStatus.loading);
      } else {
        return state.copyWith(createStatus: HashTagCreateStatus.fail);
      }
    });
  }
}
