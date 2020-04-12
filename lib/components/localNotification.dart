import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:daily_mistakes/models/mistake.dart';

List<Mistake> alertOnes = List();
List<Mistake> alertTwos = List();
List<Mistake> alertThrees = List();
List<Mistake> alertFives = List();


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocalNotifications(),
    );
  }
}

class LocalNotifications extends StatefulWidget {
   static const String id = 'localPush_page';
  @override
  _LocalNotificationsState createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<LocalNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    super.initState();
    initializing();
  }

  void initializing() async {
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void _showNotifications() async {
    await notification();
  }

  void showNotificationsAfterSecond() async {
    await alertAtLunch('yeeun test', 1);
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 'Channel title', 'channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Hello there', 'please subscribe my channel', notificationDetails);
  }

  Future<void> notificationAfterSec() async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'second channel ID', 'second Channel title', 'second channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Hello there',
        'please subscribe my channel', timeDelayed, notificationDetails);
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
  var time = Time(1, 45, 0);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            '$name channel ID', '$name Channel title', '$name channel body',
            priority: Priority.High,
            importance: Importance.Max,
            ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);

  await flutterLocalNotificationsPlugin.showDailyAtTime(
      i,
      'REMEMBER $name',
      'Notification shown at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      notificationDetails);
}

String _toTwoDigitString(int value) {
  return value.toString().padLeft(2, '0');
}


  Future onSelectNotification(String payLoad) {
    if (payLoad != null) {
      print(payLoad);
    }

    // we can set navigator to navigate another screen
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              print("");
            },
            child: Text("Okay")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              onPressed: _showNotifications,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: showNotificationsAfterSecond,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Show Notification after few sec",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

}