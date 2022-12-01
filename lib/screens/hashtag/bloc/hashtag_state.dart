part of 'hashtag_bloc.dart';

enum HashTagCreateStatus { success, fail, loading }

enum HashTagPagingStatus { success, fail, loading }

class HashtagState extends Equatable {
  final HashTagCreateStatus? createStatus;
  final HashTagPagingStatus? hashTagPagingStatus;
  final List<IdValue>? hashtags;

  HashtagState({
    this.createStatus,
    this.hashTagPagingStatus,
    this.hashtags,
  });

  @override
  List<Object?> get props => [createStatus, hashTagPagingStatus];

  HashtagState copyWith({
    HashTagCreateStatus? createStatus,
    HashTagPagingStatus? hashTagPagingStatus,
  }) {
    return HashtagState(
      createStatus: createStatus ?? this.createStatus,
      hashTagPagingStatus: hashTagPagingStatus ?? this.hashTagPagingStatus,
    );
  }
}
