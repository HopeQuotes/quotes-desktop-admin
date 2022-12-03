import 'dart:async';

import 'package:admin/domain/models/state/domain_result.dart';
import 'package:admin/models/id_value.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repository/abstraction/quote_repository.dart';

part 'create_quote_event.dart';

part 'create_quote_state.dart';

class CreateQuoteBloc extends Bloc<CreateQuoteEvent, CreateQuoteState> {
  final QuoteRepository _repository;
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final hashtags = <IdValue>[];

  CreateQuoteBloc(this._repository) : super(CreateQuoteState()) {
    on<CreateQuote>(_createQuote);
    on<RemoteHashTag>(_deleteHashtag);
    on<AddHashTag>(_addHashtag);
  }

  Future<void> _deleteHashtag(RemoteHashTag event, Emitter emitter) async {
    hashtags.add(event.hashtag);
    return emitter(state.copyWith(hashtags: hashtags));
  }

  Future<void> _addHashtag(AddHashTag event, Emitter emitter) async {
    hashtags.add(event.hashtag);
    print(state.hashtags);
    return emitter(state.copyWith(hashtags: hashtags));
  }

  Future<void> _createQuote(CreateQuote event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.createQuote(_authorController.text, _bodyController.text,
            (state.hashtags ?? []).map((e) => e.id).toList()), onData: (data) {
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
}
