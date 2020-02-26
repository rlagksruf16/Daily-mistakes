import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'package:daily_mistakes/pages/settingPage.dart';

class CustomAppBar extends StatelessWidget {


  @override
  
// 리팩토링 할 때 참고 http://bizz84.github.io/2018/09/13/BottomBar-Navigation-with-FAB.html

  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, SettingPage.id);
              },
            ),
            IconButton(
              icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, StatisticPage.id);
              },
            ),
            Container(
              height: 0,
              width: 90.0,
            ),
            IconButton(
              
              onPressed: () {
                Navigator.pushNamed(context, CalendarPage.id);

              },
              icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
            ),
            IconButton(
              icon: Icon(Icons.delete, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, OvercomePage.id);
              },
            ),
          ],
        ),
    );
  }
}



