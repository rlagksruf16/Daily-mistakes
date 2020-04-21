import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/pages/mainPage.dart';


class ButtonWithNotifications extends StatefulWidget {
  static const String id = 'buttonWithPush_page';
  ButtonWithNotifications(
      {this.title,
      this.colour,
      @required this.onPressed,});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  _ButtonWithNotificationsState createState() =>
      _ButtonWithNotificationsState();
}

class _ButtonWithNotificationsState extends State<ButtonWithNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

int idNum = 0;

  @override
  void initState() {
    super.initState();
    initializing();
    cancelAllNotifications();
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

  @override
  Widget build(BuildContext context) {
    alertSave();
    return Material(
      elevation: 5.0,
      color: widget.colour,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: widget.onPressed,
        minWidth: 200.0,
        height: 55.0,
        child: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'DoHyeon',
            fontSize: 20.0,
          ),
        ),
      ),
    );
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

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> alertAtMidnight(String name, int i) async {
    //새벽 2시
    //매일 정해진 시각에 알림
    var time = Time(2, 0, 0);
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
    var time = Time(22, 0, 0);
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
    var time = Time(9, 0, 0);
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
    var time = Time(18, 0, 0);
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
    var time = Time(12, 0, 0);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            '$name channel ID', '$name Channel title', '$name channel body',);
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

  void alertSave()  {
    int lunchlen = 0;
    int sixlen = 0;
    int morninglen = 0;
      for (int i = 0; i < alert1.length; i++) {
        alertAtLunch(alert1[i].name, i);
      }
      lunchlen = alert1.length;
      for (int i = 0; i < alert2.length; i++) {
         alertAtLunch(alert2[i].name, i + lunchlen);
      }
      lunchlen += alert2.length;
      for (int j = 0; j < alert2.length; j++) {
         alertAtSixClock(
            alert2[j].name, j);
      }
      sixlen = alert2.length;

      for (int i = 0; i < alert3.length; i++) {
        alertAtLunch(alert3[i].name, i + lunchlen);
      }
      lunchlen += alert3.length;
      for (int j = 0; j < alert3.length; j++) {
         alertAtSixClock(
            alert3[j].name, j + sixlen);
      }
      sixlen += alert3.length;
      for (int k = 0; k < alert3.length; k++) {
         alertAtMorning(
            alert3[k].name, k);
      }
      morninglen = alert3.length;

      for(int i = 0; i < alert5.length; i++) {
        alertAtLunch(alert5[i].name, i + lunchlen);
      }
      lunchlen += alert5.length;

      for(int j = 0; j < alert5.length; j++) {
        alertAtSixClock(alert5[j].name, j + sixlen);
      }
      sixlen += alert5.length;

      for(int k = 0; k < alert5.length; k++) {
        alertAtMorning(alert5[k].name, k + morninglen);
      }
      morninglen += alert5.length;

      for(int l = 0; l < alert5.length; l++) {
        alertAtTenClock(alert5[l].name, l);
      }

      for(int m = 0; m < alert5.length; m++) {
        alertAtMidnight(alert5[m].name, m);
      }

      // for (int i = 0; i < widget.alertFives.length; i++) {
      //   await alertAtLunch(widget.alertFives[i].name, i);
      // }
      // for (int j = 0; j < widget.alertFives.length; j++) {
      //   await alertAtSixClock(
      //       widget.alertFives[j].name, j + widget.alertFives.length);
      // }
      // for (int k = 0; k < widget.alertFives.length; k++) {
      //   await alertAtMorning(
      //       widget.alertFives[k].name, k + widget.alertFives.length * 2);
      // }
      // for (int l = 0; l < widget.alertFives.length; l++) {
      //   await alertAtTenClock(
      //       widget.alertFives[l].name, l + widget.alertFives.length * 3);
      // }
      // for (int m = 0; m < widget.alertFives.length; m++) {
      //   await alertAtMidnight(
      //       widget.alertFives[m].name, m + widget.alertFives.length * 4);
      // }
    }
}
  

