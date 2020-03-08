import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/constants.dart';

// 클릭추가에 따라 날짜 저장된 리스트를 불러와 비교하는 것을 만들어야 함
// 만약 비교해서 있으면 캘린더 당일 날짜 밑에 보여주고
// 캘린더 자체 밑에 카드 형식으로 count 수를 파악해서 몇개 증가했는지 보여주기
// 날짜 가져오는건 성공

var now = new DateTime.now();


final year = now.year;
final month = now.month;
final day = now.day;
final today = '$year.$month.$day';



List<Mistake> dailyMistake = List();

// void dayMistake() {
//   dailyMistake = List();

//   for(var mistake in )
// }


class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  static const Color transparent = Color(0x00000000);


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
                  selectedColor: kCoreColor,
                  selectedStyle: TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: kCoreColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonShowsNext: false,
                  formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onDaySelected: (date, events) {
                  setState(() {
                    _selectedEvents = events;
                    print(today);
                    print(dailyMistake.length);
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


