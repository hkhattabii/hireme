import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'maincontent_event.dart';
part 'maincontent_state.dart';

class MaincontentBloc extends Bloc<MaincontentEvent, MaincontentState> {
  @override
  MaincontentState get initialState => MaincontentInitial();

  @override
  Stream<MaincontentState> mapEventToState(
    MaincontentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
