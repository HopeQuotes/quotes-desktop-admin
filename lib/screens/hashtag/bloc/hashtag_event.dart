part of 'hashtag_bloc.dart';

@immutable
abstract class HashtagEvent {}

class CreateHashtag extends HashtagEvent {}

class DeleteHashtag extends HashtagEvent {}

class LoadHashTags extends HashtagEvent {}
