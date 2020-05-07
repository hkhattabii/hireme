part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}



class LoadUser extends FeedEvent {
  final User whoUseApp;
  LoadUser({this.whoUseApp});
  @override
  // TODO: implement props
  List<Object> get props => null;
}



class LikeUser extends FeedEvent {
  final User sender;
  LikeUser({this.sender});
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class UnlikeUser extends FeedEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}



