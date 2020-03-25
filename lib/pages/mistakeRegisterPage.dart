import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'calendarPage.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/components/alertPopup.dart';
import 'package:daily_mistakes/components/colorButton.dart';
import 'package:daily_mistakes/components/localNotification.dart';

String mistakeAlert = '하루에 1번';
Color mistakeColor;
String mistakeName;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  final Function addMistakeCallback;

  RegistrationScreen(this.addMistakeCallback);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                      '실수 등록',
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
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  '실수 이름 입력',
                  style: TextStyle(
                    fontFamily: 'DoHyeon',
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
                        fontFamily: 'DoHyeon',
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
                    fontFamily: 'DoHyeon',
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
                    fontFamily: 'DoHyeon',
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
                              mistakeColor = mistakeColor == Color(0xFFEC87C0)
                                  ? null
                                  : Color(0xFFEC87C0);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFFEC87C0)
                              ? Color(0x60EC87C0)
                              : Color(0xFFEC87C0),
                        ),
                        ColorButton(
                          //red
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFFF17171)
                                  ? null
                                  : Color(0xFFF17171);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFFF17171)
                              ? Color(0x60F17171)
                              : Color(0xFFF17171),
                        ),
                        ColorButton(
                          //orange
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFFFD9644)
                                  ? null
                                  : Color(0xFFFD9644);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFFFD9644)
                              ? Color(0x60FD9644)
                              : Color(0xFFFD9644),
                        ),
                        ColorButton(
                          //yellow
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFFFFCE54)
                                  ? null
                                  : Color(0xFFFFCE54);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFFFFCE54)
                              ? Color(0x60FFCE54)
                              : Color(0xFFFFCE54),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ColorButton(
                          //green
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFF57C9AE)
                                  ? null
                                  : Color(0xFF57C9AE);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFF57C9AE)
                              ? Color(0x6057C9AE)
                              : Color(0xFF57C9AE),
                        ),
                        ColorButton(
                          //lightBlue
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFF4FC1E9)
                                  ? null
                                  : Color(0xFF4FC1E9);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFF4FC1E9)
                              ? Color(0x604FC1E9)
                              : Color(0xFF4FC1E9),
                        ),
                        ColorButton(
                          //blueAccent
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFF5D9CEC)
                                  ? null
                                  : Color(0xFF5D9CEC);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFF5D9CEC)
                              ? Color(0x605D9CEC)
                              : Color(0xFF5D9CEC),
                        ),
                        ColorButton(
                          //purple
                          onPress: () {
                            setState(() {
                              mistakeColor = mistakeColor == Color(0xFFD6BBFF)
                                  ? null
                                  : Color(0xFFD6BBFF);
                            });
                          },
                          buttonColor: mistakeColor == Color(0xFFD6BBFF)
                              ? Color(0x60D6BBFF)
                              : Color(0xFFD6BBFF),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: RoundedButton(
                  title: '실수 등록',
                  colour: Colors.grey[350],
                  onPressed: () {
                    if (mistakeName == null || mistakeName == '') {
                      alertPopup(context, 1);
                    } else if (mistakeColor == null) {
                      alertPopup(context, 2);
                    } else {
                      var newMistake = Mistake(
                        name: mistakeName,
                        colour: mistakeColor,
                        alertPeriod: mistakeAlert,
                        countTime: DateTime.now(),
                      );
                      newMistake.firstMistakeTime();
                      DBHelper().createData(newMistake);
                      if (mistakeAlert == '하루에 1번') {
                        alertOnes.add(newMistake);
                        alertSave(1);
                      } else if (mistakeAlert == '하루에 2번') {
                        alertTwos.add(newMistake);
                        alertSave(2);
                      } else if (mistakeAlert == '하루에 3번') {
                        alertThrees.add(newMistake);
                        alertSave(3);
                      } else if (mistakeAlert == '하루에 5번') {
                        alertFives.add(newMistake);
                        alertSave(5);
                      }

                      print(mistakeName);
                      print(mistakeAlert);
                      print(mistakeColor);
                      print(newMistake.countTime);
                      widget.addMistakeCallback(newMistake);
                      mistakeColor = null;
                      mistakeAlert = '하루에 1번';
                      mistakeName = null;
                      Navigator.pop(context);
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
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
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
          fontFamily: 'DoHyeon',
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
            fontFamily: 'DoHyeon',
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
