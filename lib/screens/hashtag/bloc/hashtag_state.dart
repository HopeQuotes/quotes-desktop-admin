import 'package:equatable/equatable.dart';

import '../../../domain/models/ui/id_value.dart';

enum HashTagCreateStatus { success, fail, loading }

enum HashTagPagingStatus {
  successPaging,
  failPaging,
  pagingLoading,
  initialPaging
}

class HashtagState extends Equatable {
  final HashTagCreateStatus? createStatus;
  final HashTagPagingStatus? hashTagPagingStatus;
  final List<IdValue>? hashtags;
  final String? createHashtagMessage;

  @override
  List<Object?> get props =>
      [createStatus, hashTagPagingStatus, hashtags, createHashtagMessage];

  const HashtagState({
    this.createStatus,
    this.hashTagPagingStatus,
    this.hashtags,
    this.createHashtagMessage,
  });

  HashtagState copyWith({
    HashTagCreateStatus? createStatus,
    HashTagPagingStatus? hashTagPagingStatus,
    List<IdValue>? hashtags,
    String? createHashtagMessage,
  }) {
    return HashtagState(
      createStatus: createStatus ?? this.createStatus,
      hashTagPagingStatus: hashTagPagingStatus ?? this.hashTagPagingStatus,
      hashtags: hashtags ?? this.hashtags,
      createHashtagMessage: createHashtagMessage ?? this.createHashtagMessage,
    );
  }
}
