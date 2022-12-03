part of 'create_quote_bloc.dart';

enum CreateQuoteStatus { initial, success, fail, loading }

class CreateQuoteState extends Equatable {
  final CreateQuoteStatus? status;
  final List<IdValue> hashtags;
  final String? message;

  CreateQuoteState({
    this.status,
    this.message,
    this.hashtags = const [],
  });

  CreateQuoteState copyWith({
    CreateQuoteStatus? status,
    List<IdValue>? hashtags,
    String? message,
  }) {
    return CreateQuoteState(
      status: status ?? this.status,
      hashtags: hashtags ?? this.hashtags,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, hashtags, message];
}
