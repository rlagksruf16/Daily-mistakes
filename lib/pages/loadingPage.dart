import 'package:daily_mistakes/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:daily_mistakes/pages/signUp.dart';
import 'package:daily_mistakes/pages/login.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  static const String id = 'loading_page';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new StartPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 400), () {
      checkFirstSeen();
      // getData();
    });
  }

  // void getData() {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return MainPage();
  //   }));
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
