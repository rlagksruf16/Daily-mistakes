import 'dart:async';
import 'dart:ui';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

List<Mistake> alertOnes = List();
List<Mistake> alertTwos = List();
List<Mistake> alertThrees = List();
List<Mistake> alertFives = List();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

/// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
/// Please download the complete example app from the GitHub repository where all the setup has been done
Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class LocalNotification extends StatefulWidget {
  static const String id = 'localPush_page';

  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');
  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PaddedRaisedButton(
          buttonText:
              'Repeat notification every day at approximately 10:00:00 am',
          onPressed: () async {
            for (int i = 0; i < alertOnes.length; i++) {
              await alertAtMidnight(alertOnes[i].name, i);
            }
            await alertAtMidnight('실수', 1);
          },
        ),
      ),
    );
  }
}

Future<void> showNotification() async {
  //기본 알림
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> cancelNotification() async {
  //알림 삭제
  await flutterLocalNotificationsPlugin.cancel(0);
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> alertAtMidnight(String name, int i) async {
  //새벽 2시
  //매일 정해진 시각에 알림
  var time = Time(16, 5, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$name channel id', '$name channel name', '$name description');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER$name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future<void> alertAtTenClock(String name, int i) async {
  //저녁 10시
  //매일 정해진 시각에 알림
  var time = Time(16, 6, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$name channel id', '$name channel name', '$name description');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER $name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future<void> alertAtMorning(String name, int i) async {
  //아침9시
  //매일 정해진 시각에 알림
  var time = Time(16, 7, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$name channel id', '$name channel name', '$name description');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER $name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future<void> alertAtSixClock(String name, int i) async {
  //저녁 6시
  //매일 정해진 시각에 알림
  var time = Time(16, 8, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$name channel id', '$name channel name', '$name description');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER $name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future<void> alertAtLunch(String name, int i) async {
  //점심 12시
  //매일 정해진 시각에 알림
  var time = Time(16, 9, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$name channel id', '$name channel name', '$name description');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER $name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

String _toTwoDigitString(int value) {
  return value.toString().padLeft(2, '0');
}

Future<void> alertSave(int alertPeriod) async {

  if (alertPeriod == 1) { //점심 12시 알림
    for (int i = 0; i < alertOnes.length; i++) {
      await alertAtLunch(alertOnes[i].name, i);
    }
  } else if (alertPeriod == 2) { //점심 12시, 저녁 6시
    for (int i = 0; i < alertTwos.length; i++) {
      await alertAtLunch(alertTwos[i].name, i);
    }
    for (int j = 0; j < alertTwos.length; j++){
      await alertAtSixClock(alertTwos[j].name, j + alertTwos.length);
    }
  } else if (alertPeriod == 3) { //아침 9시, 점심 12시, 저녁 6시
        for (int i = 0; i < alertThrees.length; i++) {
      await alertAtLunch(alertThrees[i].name, i);
    }
    for (int j = 0; j < alertThrees.length; j++){
      await alertAtSixClock(alertThrees[j].name, j + alertThrees.length);
    }
    for(int k = 0; k < alertThrees.length; k++){
      await alertAtMorning(alertThrees[k].name, k + alertThrees.length * 2);
    }
  }
  else if (alertPeriod == 5) {//아침 9시, 점심 12시, 저녁 6시, 저녁10시, 새벽 2시
    for (int i = 0; i < alertFives.length; i++) {
      await alertAtLunch(alertFives[i].name, i);
    }
    for (int j = 0; j < alertFives.length; j++){
      await alertAtSixClock(alertFives[j].name, j + alertFives.length);
    }
    for(int k = 0; k < alertFives.length; k++){
      await alertAtMorning(alertFives[k].name, k + alertFives.length * 2);
    }
    for(int l = 0; l < alertFives.length; l++){
      await alertAtTenClock(alertFives[l].name, l + alertFives.length * 3);
    }
    for(int m = 0; m < alertFives.length; m++){
      await alertAtMidnight(alertFives[m].name, m + alertFives.length * 4);
    }
  }
}

class PaddedRaisedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PaddedRaisedButton({
    @required this.buttonText,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
    );
  }
}
