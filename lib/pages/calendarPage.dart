import 'package:daily_mistakes/models/simpleMistake.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/constants.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var now = new DateTime.now();

var count_day = 0;
List<SimpleMistake> todayMistake = List();

final year = now.year;
final month = now.month;
final day = now.day;
final today = '$year.$month.$day';

class CalendarPage extends StatefulWidget {
  static const String id = 'calendar_page';
  static const Color transparent = Color(0x00000000);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarController _calendarController;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
    FirebaseUser loggedInUser;
  String currentEmail;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        currentEmail = loggedInUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState(){
    getCurrentUser();
    _calendarController = CalendarController();
    super.initState();
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
                        fontFamily: 'Title_Light',
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
                onDaySelected: (date, selectedMistake)async {
                  // 해당 날짜를 클릭하면 해당 날짜에 해당하는 것만 뽑아야 된다
                  final years = date.year;
                  final months = date.month;
                  final days = date.day;
                  final sday = '$years.$months.$days'; // 선택한 날
                  setState(() {
                    todayMistake = List();
                  });
                  await _firestore.collection('Accounts')
                        .document(currentEmail).collection('mistakes').getDocuments().then((QuerySnapshot snapshot) {
                    snapshot.documents.forEach((m){
                      for (var i = 0; i < m.data['count']; i++){
                        _firestore.collection('Accounts')
                        .document(currentEmail).collection('mistakes').document(m.data['IDnum']).collection('countTimeList').document(i.toString()).get().then(
                          (DocumentSnapshot ds) {
                            if(ds.data['date']==sday){
                              if(todayMistake.length!=0){
                                for(var j=0; j< todayMistake.length; j++){
                                  if(todayMistake[j].name == m.data['name']){
                                    break;
                                  }
                                  if(j==todayMistake.length-1){
                                    setState(() {
                                      count_day++;
                                      todayMistake.add(SimpleMistake(
                                        name: m.data['name'],
                                        colour: Color(int.parse(m.data['colour'],radix: 16)),
                                        count: m.data['count'],
                                      ));
                                    });
                                  }
                                }
                              }else{
                                setState(() {
                                  count_day++;
                                  todayMistake.add(SimpleMistake(
                                    name: m.data['name'],
                                    colour: Color(int.parse(m.data['colour'],radix: 16)),
                                    count: m.data['count'],
                                  ));
                                });
                              }
                            }
                          });
                      }
                    });
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todayMistake.length == 0 ? 0 : todayMistake.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todayMistake[index].name),
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
          var docNum = (Random().nextInt(10000) + 1).toString();
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen(docNum),
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
      bottomNavigationBar: CustomAppBar(null),
    );
  }
}
