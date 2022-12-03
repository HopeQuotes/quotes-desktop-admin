part of 'create_quote_bloc.dart';

@immutable
abstract class CreateQuoteEvent {}

class CreateQuote extends CreateQuoteEvent {}

class AddHashTag extends CreateQuoteEvent {
  IdValue hashtag;

  AddHashTag({
    required this.hashtag,
  });
}

class RemoteHashTag extends CreateQuoteEvent {
  IdValue hashtag;

  RemoteHashTag({
    required this.hashtag,
  });
}
