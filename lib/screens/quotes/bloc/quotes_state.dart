part of 'quotes_bloc.dart';

enum QuotesPagingStatus {
  initialPaging,
  success,
  loading,
  fail,
}

enum QuoteUpdateStateStatus {
  loading,
  success,
  fail,
}

class QuotesState extends Equatable {
  final QuotesPagingStatus? quotesPagingStatus;
  final QuoteUpdateStateStatus? quoteUpdateStateStatus;
  final List<Quote>? quotes;
  final List<QuoteState>? quoteStates;
  final String? message;

  @override
  List<Object?> get props =>
      [quotesPagingStatus, quoteUpdateStateStatus, quotes, quoteStates];

  QuotesState copyWith({
    QuotesPagingStatus? quotesPagingStatus,
    QuoteUpdateStateStatus? quoteUpdateStateStatus,
    List<Quote>? quotes,
    List<QuoteState>? quoteStates,
    String? message,
  }) {
    return QuotesState(
      quotesPagingStatus: quotesPagingStatus ?? this.quotesPagingStatus,
      quoteUpdateStateStatus:
          quoteUpdateStateStatus ?? this.quoteUpdateStateStatus,
      quotes: quotes ?? this.quotes,
      quoteStates: quoteStates ?? this.quoteStates,
      message: message ?? this.message,
    );
  }

  const QuotesState({
    this.quotesPagingStatus,
    this.quoteUpdateStateStatus,
    this.quotes,
    this.quoteStates,
    this.message,
  });
}
