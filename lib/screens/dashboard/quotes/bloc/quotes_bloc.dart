import 'dart:async';

import 'package:admin/models/quote.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/state/domain_result.dart';
import '../../../../domain/repository/abstraction/create_quote_repository.dart';
import '../../../../models/id_value.dart';

part 'quotes_event.dart';

part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final QuoteRepository _repository;
  final ScrollController hashtagScrollController = ScrollController();
  int page = 1;
  var endOfPaginationReached = false;

  QuotesBloc(this._repository) : super(QuotesState()) {
    on<LoadQuotes>(_loadQuotes);
  }

  Future<void> _loadQuotes(LoadQuotes event, Emitter emitter) async {
    return emitter.forEach<DomainResult>(_repository.getHashtags(page),
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
}
