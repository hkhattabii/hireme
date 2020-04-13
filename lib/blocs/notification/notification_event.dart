part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}



class LoadNotification extends NotificationEvent {
  final User whoUseApp;
  LoadNotification({this.whoUseApp});

  @override
  // TODO: implement props
  List<Object> get props => [whoUseApp];

}
