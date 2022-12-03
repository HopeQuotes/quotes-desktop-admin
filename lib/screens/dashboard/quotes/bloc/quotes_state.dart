part of 'quotes_bloc.dart';

enum QuotesPagingStatus {
  initialPaging,
  success,
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
  final String? message;

  @override
  List<Object?> get props =>
      [quotesPagingStatus, quoteUpdateStateStatus, quotes];

  const QuotesState(
      {this.quotesPagingStatus,
      this.quoteUpdateStateStatus,
      this.message,
      this.quotes});

  QuotesState copyWith({
    QuotesPagingStatus? quotesPagingStatus,
    QuoteUpdateStateStatus? quoteUpdateStateStatus,
    List<Quote>? quotes,
    String? message,
  }) {
    return QuotesState(
      quotesPagingStatus: quotesPagingStatus ?? this.quotesPagingStatus,
      quoteUpdateStateStatus:
          quoteUpdateStateStatus ?? this.quoteUpdateStateStatus,
      quotes: quotes ?? this.quotes,
      message: message ?? this.message,
    );
  }
}
