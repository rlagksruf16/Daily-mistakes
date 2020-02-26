import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:daily_mistakes/pages/mainPage.dart';



class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(

                    minWidth: 10,
                    onPressed: () {
                      setState(() {
                        currentScreen = MainPage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                      Navigator.pushNamed(context, MainPage.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = StatisticPage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                      Navigator.pushNamed(context, StatisticPage.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.show_chart,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons
              // Container(
              //   EdgeInsetsGeometry
              //   height: 0,
              //   width: 50.0,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = CalendarPage(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                      Navigator.pushNamed(context, CalendarPage.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 20,
                    onPressed: () {
                      setState(() {
                        currentScreen = OvercomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                      Navigator.pushNamed(context, OvercomePage.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
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



