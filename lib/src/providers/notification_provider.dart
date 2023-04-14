import 'package:chat/src/providers/users_providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PushNotificationProvider extends GetConnect {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notification',
    importance: Importance.high,
  );

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  void initPushNotification() async {
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void onMessageListiner() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Nova Notificacao ${message.data}');
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Nova notificacao ddgdgdgdgdgdg');
    });
  }

  Future<Uint8List> _getByteArrayFormUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationDetails? androidPlatformChannelSpecifics;

    if (message.data['url'] == '') {
        androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: 'launch_background',
      );
    } else {
      ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
          await _getByteArrayFormUrl(message.data['url']));
      BigPictureStyleInformation information = BigPictureStyleInformation(
        bigPicture,
        contentTitle: message.data['title'],
        htmlFormatContentTitle: true,
        summaryText: message.data['body'],
        htmlFormatSummaryText: true,
      );

       androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        icon: 'launch_background',
        styleInformation: information
      );
    }

    plugin.show(
      int.parse(message.data['id_chat']),
      message.data['title'],
      message.data['body'],
      NotificationDetails(android: androidPlatformChannelSpecifics),
    );
  }

  Future<Response> sendMessage(String token, Map<String, dynamic> data) async {
    Response response = await post('https://fcm.googleapis.com/fcm/send', {
      'priority': 'high',
      'ttl': '4500s',
      'data': data,
      'to': token,
    }, headers: {
      'Content-Type': 'Application/json',
      'Authorization':
          'key=AAAARYsii2M:APA91bFUEziQQMWaNqsUixLX2ZvG0JPY51A44qGh7tassnEPAhLUE3w4b_jLbuOVHs-b1U4d8lZfe-YvaeNC-VuzAXWg_EdtIeEgqkXJm5xdfPqOyn77uipQ6dTTazallCEKnFvfzEIq'
    });

    return response;
  }

  void saveToken(String idUser) async {
    String? token = await FirebaseMessaging.instance.getToken();
    UsersProvider usersProvider = UsersProvider();
    if (token != null) {
      await usersProvider.updateNotificationToken(idUser, token);
    }
  }
}
