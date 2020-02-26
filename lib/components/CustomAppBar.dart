import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';

class CustomAppBar extends StatelessWidget {
  
  int currentTab = 0;

  @override
  
// 리팩토링 할 때 참고 http://bizz84.github.io/2018/09/13/BottomBar-Navigation-with-FAB.html

  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        height: 60.0,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // MaterialButton(
            //   minWidth: 40,
            //   onPressed: () {
            //     currentTab = 0;
            //     Navigator.pushNamed(context, SettingPage.id);
            //   },
            //   child: Column(
            //     children: <Widget>[
            //       Icon(Icons.settings, size: 30.0, color: currentTab == 0 ? Colors.blue : Colors.grey,),
            //       Text('Setting', style: TextStyle(color: currentTab == 0 ? Colors.blue : Colors.grey),),
            //     ], 
            //   ),
            // ),
            // MaterialButton(
            //   minWidth: 40,
            //   onPressed: () {
            //     currentTab = 1;
            //     Navigator.pushNamed(context, StatisticPage.id);
            //   },
            //   child: Column(
            //     children: <Widget>[
            //       Icon(Icons.show_chart, size: 30.0, color: currentTab == 1 ? Colors.blue : Colors.grey,),
            //       Text('Chart', style: TextStyle(color: currentTab == 1 ? Colors.blue : Colors.grey),),
            //     ], 
            //   ),
            // ),
            // Container(
            //   height: 0,
            //   width: 90.0,
            // ),
            // MaterialButton(
            //   minWidth: 40,
            //   onPressed: () {
            //     currentTab = 2;
            //     Navigator.pushNamed(context, CalendarPage.id);
            //   },
            //   child: Column(
            //     children: <Widget>[
            //       Icon(Icons.calendar_today, size: 30.0, color: currentTab == 2 ? Colors.blue : Colors.grey,),
            //       Text('Setting', style: TextStyle(color: currentTab == 2 ? Colors.blue : Colors.grey),),
            //     ], 
            //   ),
            // ),
            // MaterialButton(
            //   minWidth: 40,
            //   onPressed: () {
            //     currentTab = 3;
            //     Navigator.pushNamed(context, OvercomePage.id);
            //   },
            //   child: Column(
            //     children: <Widget>[
            //       Icon(Icons.delete, size: 30.0, color: currentTab == 3 ? Colors.blue : Colors.grey,),
            //       Text('Setting', style: TextStyle(color: currentTab == 3 ? Colors.blue : Colors.grey),),
            //     ], 
            //   ),
            // ),
            IconButton(
              icon: Icon(Icons.settings, size: 30.0, color: Colors.grey),
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, StatisticPage.id);
                currentTab = 1;
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
      ),
    );
  }
}



