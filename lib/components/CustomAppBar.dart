import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:daily_mistakes/constants.dart';
import 'package:daily_mistakes/models/simpleMistake.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color nonColor = Colors.grey[400];

class CustomAppBar extends StatefulWidget {
  CustomAppBar(this.controller);
  ScrollController controller;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  double barWidth = 70;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      child: Container(
        height: 45,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  minWidth: barWidth,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          MainPage(); // if user taps on this dashboard tab will be active
                      currentTab = 0;
                    });
                    if (widget.controller != null) {
                      widget.controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    }
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            MainPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: currentTab == 0 ? kCoreColor : nonColor,
                      ),
                      Text(
                        '홈',
                        style: TextStyle(
                          color: currentTab == 0 ? kCoreColor : nonColor,
                          fontFamily: 'Title_Light',
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: barWidth,
                  onPressed: () async {
                    final _firestore = Firestore.instance;
                    final _auth = FirebaseAuth.instance;
                    await _firestore
                        .collection('mistakes')
                        .getDocuments()
                        .then((QuerySnapshot snapshot) {
                      snapshot.documents.forEach((f) {
                        setState(() {
                          sortedMistakes.add(SimpleMistake(
                            name: f.data['name'],
                            colour:
                                Color(int.parse(f.data['colour'], radix: 16)),
                            count: f.data['count'],
                          ));
                        });
                      });
                    });
                    setState(() {
                      sortedMistakes.sort(countComparator);
                      currentScreen =
                          StatisticPage(); // if user taps on this dashboard tab will be active
                      currentTab = 1;
                    });
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            StatisticPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.show_chart,
                        color: currentTab == 1 ? kCoreColor : nonColor,
                      ),
                      Text(
                        '차트',
                        style: TextStyle(
                          color: currentTab == 1 ? kCoreColor : nonColor,
                          fontFamily: 'Title_Light',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 0,
              width: 50.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  minWidth: barWidth,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          CalendarPage(); // if user taps on this dashboard tab will be active
                      currentTab = 2;
                    });
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            CalendarPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: currentTab == 2 ? kCoreColor : nonColor,
                      ),
                      Text(
                        '달력',
                        style: TextStyle(
                          color: currentTab == 2 ? kCoreColor : nonColor,
                          fontFamily: 'Title_Light',
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: barWidth,
                  onPressed: () {
                    setState(() {
                      currentScreen =
                          OvercomePage(); // if user taps on this dashboard tab will be active
                      currentTab = 3;
                    });
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            OvercomePage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: currentTab == 3 ? kCoreColor : nonColor,
                      ),
                      Text(
                        '극복',
                        style: TextStyle(
                          color: currentTab == 3 ? kCoreColor : nonColor,
                          fontFamily: 'Title_Light',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class CustomAppBar extends StatelessWidget {

//   @override

// // 리팩토링 할 때 참고 http://bizz84.github.io/2018/09/13/BottomBar-Navigation-with-FAB.html

//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       shape: CircularNotchedRectangle(),
//       notchMargin: 4.0,
//         child: Row(
//           // mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.settings, size: 30.0, color: Colors.grey),
//               onPressed: () {
//                 Navigator.pushNamed(context, SettingPage.id);
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
//               onPressed: () {
//                 Navigator.pushNamed(context, StatisticPage.id);
//               },
//             ),
//             Container(
//               height: 0,
//               width: 90.0,
//             ),
//             IconButton(

//               onPressed: () {
//                 Navigator.pushNamed(context, CalendarPage.id);

//               },
//               icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, size: 30.0, color: Colors.grey),
//               onPressed: () {
//                 Navigator.pushNamed(context, OvercomePage.id);
//               },
//             ),
//           ],
//         ),
//     );
//   }
// }
