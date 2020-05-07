import 'package:hireme/models/Table.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepository with Table {

  static void registerNotification() {
    FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
    firebaseMessaging.requestNotificationPermissions();

    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('onMessage : $message');
    });
  }




}