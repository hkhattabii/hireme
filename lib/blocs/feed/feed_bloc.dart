import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/CandidateRepository.dart';
import 'package:hireme/repositories/RecruiterRepository.dart';
import 'package:hireme/repositories/UserRepository.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  @override
  FeedState get initialState => FeedStateUninitialized();

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is LoadUser) {
      yield* _mapLoadUserState(event);
    } else if (event is LikeUser) {
      yield* _mapLikeUserState(event);
    } else if (event is UnlikeUser) {
      yield* _mapUnlikeUserState(event);
    } 
  }

  Stream<FeedState> _mapLoadUserState(LoadUser event) async* {
    List<User> userSuggestion;
    if (event.whoUseApp.accountType == AccountType.RECRUITER) {
      userSuggestion =
          (await RecruiterRepository.getPotentialCandidate(recruiter: event.whoUseApp)).reversed.toList();
    } else {
      userSuggestion = (await CandidateRepository.getPotentialRecruiters(candidate: event.whoUseApp)).reversed.toList();
    }

    if (userSuggestion.isEmpty) {
      yield FeedStateEmpty();
    } else {
    yield FeedStateInitialized(
        userSuggestions: userSuggestion, userSuggesting: userSuggestion[0]);
    }


  }

  Stream<FeedState> _mapLikeUserState(LikeUser event) async* {
    List<User> userSuggestionUpdated =
        (List.from((state as FeedStateInitialized).userSuggestions))
          ..removeAt(0);

      UserRepository.interest(receiver: (state as FeedStateInitialized).userSuggesting, sender: event.sender);

    if (userSuggestionUpdated.isEmpty) {
      yield FeedStateEmpty();
    } else {
      yield FeedStateInitialized(
          userSuggestions: userSuggestionUpdated,
          userSuggesting: userSuggestionUpdated[0]);
    }
  }

  Stream<FeedState> _mapUnlikeUserState(UnlikeUser event) async* {
    List<User> userSuggestionUpdated =
        (List.from((state as FeedStateInitialized).userSuggestions))
          ..removeAt(0);

    if (userSuggestionUpdated.isEmpty) {
      yield FeedStateEmpty();
    } else {
      yield FeedStateInitialized(
          userSuggestions: userSuggestionUpdated,
          userSuggesting: userSuggestionUpdated[0]);
    }
  }


}
