import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
import 'package:daily_mistakes/models/mistake.dart';

// 요일별로 카운트 증가한 것에 대해서 캘린더에 색깔로 표시해야함
// 요일을 클릭했을 시에 그 요일에 해당하는 실수의 카운트 수를 보여줘야 함

const Color coreColor = Color(0xFF5f80f4);
List<Mistake> bestMistakes = List();


class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  static const Color transparent = Color(0x00000000);

  static const Color coreColor = Color(0xFF03A9F4);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  CalendarController _calendarController;

  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  List<dynamic> _selectedEvents;



  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
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
                events: _events,
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(
                  todayStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                  todayColor: Colors.transparent,
                  selectedColor: coreColor,
                  selectedStyle: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xFF5f80f4),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonShowsNext: false,
                  formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onDaySelected: (date, events) {
                  setState(() {
                    _selectedEvents = events;
                    print(date);
                  });
                },
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemBuilder: null,)
              // ),
            ],
          ),
        ),
      ),
      
      // TableCalendar(calendarController: _calendarController,),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomActionButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>RegistrationScreen((newMistake){
              setState(() {
                mistakes.add(newMistake);
              });
            })
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(),
    );
  }























  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            onPressed: (){
              if(_eventController.text.isEmpty) return;
              setState(() {
                if(_events[_calendarController.selectedDay] != null) {
                  _events[_calendarController.selectedDay].add(_eventController.text);
                }
                else {
                  _events[_calendarController.selectedDay] = [_eventController.text];
                }
                _eventController.clear();
                Navigator.pop(context);
              });
              
            },
          )
        ],
      )
    );
  }
}


