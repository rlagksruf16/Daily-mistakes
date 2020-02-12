import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'calendarPage.dart';

enum Colours {
  pink,
  red,
  orange,
  yellow,
  green,
  lightblue,
  blue,
  purple,
  white,
}

Colours selectedButton = Colours.white;
String mistakeAlert;

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String mistakeName;
  String mistakeColor;

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
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.pink;
                            });
                          },
                          buttonColor: selectedButton == Colours.pink
                              ? Colors.pink[50]
                              : Colors.pink,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.red;
                            });
                          },
                          buttonColor: selectedButton == Colours.red
                              ? Colors.red[50]
                              : Colors.red,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.orange;
                            });
                          },
                          buttonColor: selectedButton == Colours.orange
                              ? Colors.orange[50]
                              : Colors.orange,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.yellow;
                            });
                          },
                          buttonColor: selectedButton == Colours.yellow
                              ? Colors.yellow[50]
                              : Colors.yellow,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.green;
                            });
                          },
                          buttonColor: selectedButton == Colours.green
                              ? Colors.green[50]
                              : Colors.green,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.lightblue;
                            });
                          },
                          buttonColor: selectedButton == Colours.lightblue
                              ? Colors.lightBlue[50]
                              : Colors.lightBlue,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.blue;
                            });
                          },
                          buttonColor: selectedButton == Colours.blue
                              ? Colors.blueAccent[50]
                              : Colors.blueAccent,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                              selectedButton = Colours.purple;
                            });
                          },
                          buttonColor: selectedButton == Colours.purple
                              ? Colors.purple[50]
                              : Colors.purple,
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
                    mistakeColor = selectedButton.toString();
                    print(mistakeName); //print부분 다 지워도 됨.
                    print(mistakeAlert);
                    print(mistakeColor);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () {
          Navigator.pushNamed(context, MainPage.id);
        },
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
          '하루에 1번',
          '하루에 2번',
          '하루에 3번',
          '하루에 5번',
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

class ColorButton extends StatelessWidget {
  ColorButton({
    @required this.onPress,
    @required this.buttonColor,
  });

  final Function onPress;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
