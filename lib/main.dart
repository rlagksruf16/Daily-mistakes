import 'package:daily_mistakes/components/localNotification.dart';
import 'package:daily_mistakes/pages/mistakeModifyPage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'package:flutter/material.dart';
import 'pages/mainPage.dart';
import 'pages/mistakeRegisterPage.dart';
import 'pages/overcomePage.dart';
import 'pages/calendarPage.dart';
import 'pages/statisticPage.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'pages/settingPage.dart';
//import 'package:daily_mistakes/components/pushNotification.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //backgroundColor: Colors.yellow,
        
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainPage.id,
      routes: {
        LocalNotifications.id: (context) => LocalNotifications(),
        // HomePage.id: (context) => HomePage(),
        MainPage.id: (context) => MainPage(),
        // RegistrationScreen.id: (context) => RegistrationScreen(),
        OvercomePage.id: (context) => OvercomePage(),
        CalendarPage.id: (context) => CalendarPage(),
        StatisticPage.id: (context) => StatisticPage(),
        SettingPage.id: (context) => SettingPage(),
        // MistakeModifyPage.id: (context) => MistakeModifyPage(),

        
      },
    );
  }
}


