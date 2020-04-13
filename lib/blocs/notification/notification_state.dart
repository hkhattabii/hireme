part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationStateUninitialized extends NotificationState {
  @override
  List<Object> get props => [];
}



class NotificationStateEmpty extends NotificationState {
    @override
  List<Object> get props => [];
}

class NotificationStateInitialized extends NotificationState {
  final List<UserNotification> notifications;
  NotificationStateInitialized({this.notifications});  
      @override
  List<Object> get props => [notifications];
}
