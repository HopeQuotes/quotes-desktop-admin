part of 'create_quote_bloc.dart';

enum CreateQuoteStatus { initial, success, fail, loading }

enum HashTagPagingStatus {
  successPaging,
  failPaging,
  pagingLoading,
  initialPaging
}

class CreateQuoteState extends Equatable {
  final CreateQuoteStatus? status;
  final List<IdValue>? hashtags;
  final List<IdValue>? userHashtags;
  final String? message;
  final HashTagPagingStatus? hashTagPagingStatus;

  @override
  List<Object?> get props =>
      [status, hashtags, message, hashTagPagingStatus, userHashtags];

  const CreateQuoteState(
      {this.status,
      this.hashtags,
      this.message,
      this.hashTagPagingStatus,
      this.userHashtags});

  CreateQuoteState copyWith({
    CreateQuoteStatus? status,
    List<IdValue>? hashtags,
    List<IdValue>? userHashtags,
    String? message,
    HashTagPagingStatus? hashTagPagingStatus,
  }) {
    return CreateQuoteState(
      status: status ?? this.status,
      hashtags: hashtags ?? this.hashtags,
      userHashtags: userHashtags ?? this.userHashtags,
      message: message ?? this.message,
      hashTagPagingStatus: hashTagPagingStatus ?? this.hashTagPagingStatus,
    );
  }
}
