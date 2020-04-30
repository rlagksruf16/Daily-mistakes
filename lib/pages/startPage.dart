import 'package:daily_mistakes/main.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

changeBuffer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('infoCheck', true);
}

class StartPage extends StatefulWidget {
  static const String id = 'start_page';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var screen = [
    'assets/info1.png',
    'assets/info2.png',
    'assets/info3.png',
    'assets/info4.png',
    'assets/info5.png',
    'assets/info6.png',
    'assets/info7.png',
    'assets/info8.png',
    'assets/info9.png',
    'assets/info10.png',
    'assets/info11.png',
    'assets/info12.png',
    'assets/info13.png',
    'assets/info14.png',
    'assets/info15.png',
    'assets/info17.png',
    'assets/info18.png',
    'assets/info19.png',
  ];

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    if (i == 17) {
                      // changeBuffer();
                      // if (infoCheck == true) {
                      //   // Navigator.pushNamed(context, MainPage.id);
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(builder: (context) => new MainPage())
                        );
                     // }
                    } else {
                      i++;
                    }
                  });
                },
                child: Image.asset(screen[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
