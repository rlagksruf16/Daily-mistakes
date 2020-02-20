
import 'package:flutter/material.dart';
import 'pages/mainPage.dart';
import 'pages/mistakeRegisterPage.dart';
import 'pages/overcomePage.dart';
import 'pages/calendarPage.dart';
import 'package:daily_mistakes/models/mistake.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainPage.id,
      routes: {
        MainPage.id: (context) => MainPage(),
        //RegistrationScreen.id: (context) => RegistrationScreen(),
        OvercomePage.id: (context) => OvercomePage(),
        CalendarPage.id: (context) => CalendarPage(),

        
      },
    );
  }
}

