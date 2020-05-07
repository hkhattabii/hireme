import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireme/blocs/notification/notification_bloc.dart';
import 'package:hireme/models/Notification.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (BuildContext context, NotificationState state) {
          if (state is NotificationStateUninitialized) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotificationStateInitialized) {
            List<UserNotification> notifications = state.notifications;
            FirebaseMessaging fcm = new FirebaseMessaging();
            fcm.configure(
              onMessage: (Map<String, dynamic> message) async {
                print('onMessage: $message');
              },
              onLaunch: (Map<String, dynamic> message) async {
                print('onMessage: $message');
              },
              onResume: (Map<String, dynamic> message) async {
                print('onMessage: $message');
              }
            );
            fcm.requestNotificationPermissions(IosNotificationSettings());
            return ListView.separated(
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  UserNotification notification = notifications[index];
                  return ListTile(
                    title: Text(notification.message),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print("delete notification");
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.black));
          }
          return Container();
        }));
  }
}
