import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hireme/models/Notification.dart';
import 'package:hireme/models/User.dart';
import 'package:hireme/repositories/UserRepository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  @override
  NotificationState get initialState => NotificationStateUninitialized();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is LoadNotification) {
      yield* _mapLoadNotificiationState(event);
    }
  }


  Stream<NotificationState> _mapLoadNotificiationState(LoadNotification event) async* {
    List<UserNotification> notifications = await UserRepository.getNotifications(event.whoUseApp.id);

    if (notifications.isEmpty) {
      yield NotificationStateEmpty();
    }

    yield NotificationStateInitialized(notifications: notifications);
  }




}
