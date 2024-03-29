import 'dart:async';

import 'package:admin/utils/controller.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/state/domain_result.dart';
import '../../../../domain/models/ui/quote.dart';
import '../../../../domain/repository/abstraction/quotes_repository.dart';

part 'quotes_event.dart';

part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final QuotesRepository _repository;
  final ScrollController hashtagScrollController = ScrollController();
  int page = 1;
  var endOfPaginationReached = false;

  QuotesBloc(this._repository) : super(QuotesState()) {
    on<LoadQuotes>(_loadQuotes);
    on<GetQuoteStates>(_loadQuoteStates);
    on<SetQuoteState>(_setQuoteState);

    hashtagScrollController.onBottomReached(() {
      if (!endOfPaginationReached) {
        page++;
        add(LoadQuotes());
      }
    });
  }

  Future<void> _loadQuotes(LoadQuotes event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getQuotes(page),
        onData: (data) {
      if (data is DomainSuccess<List<Quote>>) {
        endOfPaginationReached = (data.data ?? []).length < 20;
        return state.copyWith(
            quotesPagingStatus: QuotesPagingStatus.success,
            quotes: (state.quotes ?? []) + (data.data ?? []));
      }
      if (data is DomainError) {
        return state.copyWith(quotesPagingStatus: QuotesPagingStatus.fail);
      }
      return state;
    });
  }

  Future<void> _loadQuoteStates(GetQuoteStates event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getQuoteStates(),
        onData: (data) {
      if (data is DomainSuccess<List<QuoteState>>) {
        return state.copyWith(quoteStates: data.data);
      }
      return state;
    });
  }

  Future<void> _setQuoteState(SetQuoteState event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(
        _repository.setQuoteState(event.stateId, event.quoteId),
        onData: (data) {
      return state;
    });
  }
}
