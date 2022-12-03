part of 'create_quote_bloc.dart';

@immutable
abstract class CreateQuoteEvent {}

class CreateQuote extends CreateQuoteEvent {}

class AddHashTag extends CreateQuoteEvent {
  final IdValue hashtag;

  AddHashTag({
    required this.hashtag,
  });
}

class LoadHashTags extends CreateQuoteEvent {}

class RemoteHashTag extends CreateQuoteEvent {
  final IdValue hashtag;

  RemoteHashTag({
    required this.hashtag,
  });
}
