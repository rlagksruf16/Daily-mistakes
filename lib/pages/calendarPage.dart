import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';

const Color coreColor = Color(0xFF03A9F4);

class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  static const Color transparent = Color(0x00000000);

  static const Color coreColor = Color(0xFF03A9F4);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      'Calendar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontFamily: 'DoHyeon',
                        fontWeight: FontWeight.bold,
                        ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              TableCalendar(
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(
                  todayStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                  todayColor: Colors.transparent,
                  selectedColor: Colors.black,
                  selectedStyle: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonShowsNext: false,
                ),
                onDaySelected: (date, events) {
                  print(date.toIso8601String());
                },
              ),
            ],
          ),
        ),
      ),
      
      // TableCalendar(calendarController: _calendarController,),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, MainPage.id);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, CalendarPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}


