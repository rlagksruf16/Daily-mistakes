import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'calendarPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/components/alertPopup.dart';
import 'package:daily_mistakes/components/colorButton.dart';
// import 'package:daily_mistakes/components/localNotification.dart';
import 'package:daily_mistakes/components/ButtonWithNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daily_mistakes/models/simpleMistake.dart';

String mistakeAlert = '하루에 1번';
String mistakeColor;
String mistakeName;


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  final docNum;
  RegistrationScreen(this.docNum);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                      '실수 등록',
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
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  '실수 이름 입력',
                  style: TextStyle(
                    fontFamily: 'Title_Light',
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    mistakeName = value;
                  },
                  decoration: InputDecoration(
                    labelText: "실수 이름을 입력하세요",
                    labelStyle: TextStyle(
                        fontFamily: 'Title_Light',
                        fontSize: 15.0,
                        color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  '알람 주기 설정',
                  style: TextStyle(
                    fontFamily: 'Title_Light',
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: DropeddownButton(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  '실수 색상 설정',
                  style: TextStyle(
                    fontFamily: 'Title_Light',
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                //colorButtons
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ColorButton(
                          //pink
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FFEEAEAF"
                                  ? null
                                  : "FFEEAEAF";
                            });
                          },
                          buttonColor: mistakeColor == "FFEEAEAF"
                              ? Color(0x60EEAEAF)
                              : Color(0xFFEEAEAF),
                        ),
                        ColorButton(
                          //orange
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FFFF986F"
                                  ? null
                                  : "FFFF986F";
                            });
                          },
                          buttonColor: mistakeColor == "FFFF986F"
                              ? Color(0x60FF986F)
                              : Color(0xFFFF986F),
                        ),
                        ColorButton(
                          //green
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FF95BB8B"
                                  ? null
                                  : "FF95BB8B";
                            });
                          },
                          buttonColor: mistakeColor == "FF95BB8B"
                              ? Color(0x6095BB8B)
                              : Color(0xFF95BB8B),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ColorButton(
                          //lightBlue
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FF94C2DA"
                                  ? null
                                  : "FF94C2DA";
                            });
                          },
                          buttonColor: mistakeColor == "FF94C2DA"
                              ? Color(0x6094C2DA)
                              : Color(0xFF94C2DA),
                        ),
                        ColorButton(
                          //blueAccent
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FF4371B2"
                                  ? null
                                  : "FF4371B2";
                            });
                          },
                          buttonColor: mistakeColor == "FF4371B2"
                              ? Color(0x604371B2)
                              : Color(0xFF4371B2),
                        ),
                        ColorButton(
                          //purple
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == "FFC7A4D6"
                                  ? null
                                  : "FFC7A4D6";
                            });
                          },
                          buttonColor: mistakeColor == "FFC7A4D6"
                              ? Color(0x60C7A4D6)
                              : Color(0xFFC7A4D6),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: ButtonWithNotifications(
                  title: '실수 등록',
                  colour: Colors.grey[350],
                  onPressed: () async {
                    if (mistakeName == null || mistakeName == '') {
                      alertPopup(context, 1);
                    } else if (mistakeColor == null) {
                      alertPopup(context, 2);
                    } else {
                      var now = new DateTime.now();
                      var year = now.year;
                      var month = now.month;
                      var day = now.day;
                      var today = '$year.$month.$day';
                      await _firestore
                        .collection('Accounts')
                        .document(currentEmail)
                        .collection('mistakes')
                        .document(widget.docNum)
                        .setData({
                          'IDnum': widget.docNum,
                          'name': mistakeName,
                          'colour': mistakeColor,
                          'alertPeriod': mistakeAlert,
                          'count': 0,
                        });
                      await _firestore
                        .collection('Accounts')
                        .document(currentEmail)
                        .collection('mistakes')
                        .document(widget.docNum)
                        .collection('countTimeList')
                        .document('0')
                        .setData({
                          'date': today,
                        });
/*
                      setState(() {
                        if (mistakeAlert == '하루에 1번') {
                          alert1.add(newMistake);
                        } else if (mistakeAlert == '하루에 2번') {
                          alert2.add(newMistake);
                        } else if (mistakeAlert == '하루에 3번') {
                          alert3.add(newMistake);
                        } else if (mistakeAlert == '하루에 5번') {
                          alert5.add(newMistake);
                        }
                      });
                      */

                      print(mistakeName);
                      print(mistakeAlert);
                      print(mistakeColor);
                      mistakeColor = null;
                      mistakeAlert = '하루에 1번';
                      mistakeName = null;
                      await Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomActionButton(
        icon: Icon(Icons.home),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: CustomAppBar(null),
    );
  }
}

class DropeddownButton extends StatefulWidget {
  // DropeddownButton({@required this.onChanged});

  // final Function onChanged;

  @override
  _DropeddownButtonState createState() => _DropeddownButtonState();
}

class _DropeddownButtonState extends State<DropeddownButton> {
  String firstvalue = '하루에 1번';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 10.0),
      child: DropdownButton<String>(
        value: firstvalue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15.0,
          fontFamily: 'Title_Light',
        ),
        onChanged: (String newValue) {
          setState(() {
            firstvalue = newValue;
            mistakeAlert = newValue;
          });
        },
        items: <String>[
          '하루에 1번', //점심 12시
          '하루에 2번', //점심 12시, 저녁 6시
          '하루에 3번', //아침 9시, 점심 12시, 저녁 6시
          '하루에 5번', //아침 9시, 점심 12시, 저녁 6시, 저녁10시, 새벽 2시
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({
    this.title,
    this.colour,
    @required this.onPressed,
  });

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: colour,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 55.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Title_Light',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
