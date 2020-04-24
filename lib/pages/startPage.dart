import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';

class StartPage extends StatefulWidget {
  static const String id = 'start_page';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var screen = [
    'assets/main0.png',
    'assets/main1.png',
    'assets/register.png',
    'assets/main2.png',
    'assets/calendar.png',
    'assets/statistics.png'
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
                child: Image.asset(screen[i]),
                onTap: () {
                  setState(() {
                    i++;
                    if (i == 6) {
                      Navigator.pushNamed(context, MainPage.id);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
