import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/constants.dart';

// 클릭추가에 따라 날짜 저장된 리스트를 불러와 비교하는 것을 만들어야 함
// 만약 비교해서 있으면 캘린더 당일 날짜 밑에 보여주고
// 캘린더 자체 밑에 카드 형식으로 count 수를 파악해서 몇개 증가했는지 보여주기
// 날짜 가져오는건 성공

// 애초에 리스트를 초기화하는 방법도 나쁘지않을듯

var now = new DateTime.now();

var count = 0;
List<Mistake> todayMistake = [];

final year = now.year;
final month = now.month;
final day = now.day;
final today = '$year.$month.$day';

// void CountMistakePerDay() {
//   for (var i = 0; i < mistakes.length; i++) {
//     // for (var j = 0; j < mistakes[i].countTimeList.length; j++) {
//     if (mistakes[i].countTimeList.contains(today))
//       // 있으면 리스트에 넣어주기
//       count++;
//     todayMistake.add(mistakes[i]);
//   }
// }

class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  static const Color transparent = Color(0x00000000);

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
                  formatButtonTextStyle:
                      TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                onDaySelected: (date, selectedMistake) {
                  setState(() {
                    todayMistake = List();
                    // 해당 날짜를 클릭하면 해당 날짜에 해당하는 것만 뽑아야 된다
                    final years = date.year;
                    final months = date.month;
                    final days = date.day;
                    final sday = '$years.$months.$days'; // 선택한 날
                    print(todayMistake.length);
                    for (var i = 0; i < mistakes.length; i++) {
                      if (mistakes[i].countTimeList.contains(sday)) {
                        // 있으면 리스트에 넣어주기
                        count++;
                      todayMistake.add(mistakes[i]);
                      }
                    }
                    
                    print(todayMistake.length);
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todayMistake.length == 0 ? 0 : todayMistake.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todayMistake[index].name),
                      // subtitle: Text(todayMistake[index].),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomActionButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen((newMistake) {
                      setState(() {
                        mistakes.add(newMistake);
                        sortedMistakes.add(newMistake);
                      });
                    }),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(),
    );
  }
}
