part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();
}


class FeedStateUninitialized extends FeedState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}


class FeedStateEmpty extends FeedState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}

class FeedStateInitialized extends FeedState {
  final List<User> userSuggestions;
  final User userSuggesting;

  FeedStateInitialized({this.userSuggestions, this.userSuggesting});

  FeedStateInitialized update({List<User> userSuggestion, User userSuggesting}) {
    return FeedStateInitialized(
        userSuggestions: userSuggestions ?? this.userSuggestions,
        userSuggesting: userSuggesting ?? this.userSuggesting);
  }

  @override
  // TODO: implement props
  List<Object> get props => [userSuggestions, userSuggesting];
}