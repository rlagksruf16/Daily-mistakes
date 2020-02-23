import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';

class CustomAppBar extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, size: 30.0, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
            onPressed: () {
              // Navigator.pushNamed(context, StatisticPage.id);
            },
          ),
          Container(
            height: 0,
            width: 90.0,
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
            onPressed: () {
              Navigator.pushNamed(context, CalendarPage.id);
            },
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