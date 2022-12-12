part of 'quotes_bloc.dart';

@immutable
abstract class QuotesEvent {}

class LoadQuotes extends QuotesEvent {}

class GetQuoteStates extends QuotesEvent {}

class SetQuoteState extends QuotesEvent {
  final String stateId;
  final String quoteId;

  SetQuoteState({
    required this.stateId,
    required this.quoteId,
  });
}
