import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Colours selectedButton = Colours.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 100.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '실수 등록',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontFamily: 'DoHyeon',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '실수 이름 입력',
                style: TextStyle(
                  fontFamily: 'DoHyeon',
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {},
                decoration: kTextFieldDecoration.copyWith(hintText: '실수 이름 입력'),
              ),
              SizedBox(
                height: 28.0,
              ),
              Text(
                '알람 주기 설정',
                style: TextStyle(
                  fontFamily: 'DoHyeon',
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              DropeddownButton(),
              SizedBox(
                height: 28.0,
              ),
              Text(
                '실수 색상 설정',
                style: TextStyle(
                  fontFamily: 'DoHyeon',
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
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
              SizedBox(
                height: 30.0,
              ),
              RoundedButton(
                title: '실수 등록',
                colour: Colors.grey[350],
                onPressed: () {
                  _popUpScreen(context); //팝업 테스트 용
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
  // border: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  hintStyle: TextStyle(
    fontFamily: 'DoHyeon',
    fontSize: 15.0,
    color: Colors.grey,
  ),
);

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
            color: Colors.white,
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
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        // height: kBottomContainerHeight,
      ),
    );
  }
}


_popUpScreen(context) {
  var alertStyle = AlertStyle(
    titleStyle: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontFamily: 'DoHyeon',
      fontWeight: FontWeight.bold,
    ),
  );

  Alert(
      context: context,
      title: "실수 등록",
      style: alertStyle,
      content: 
       Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '실수 이름 입력',
              style: TextStyle(
                fontFamily: 'DoHyeon',
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(hintText: '실수 이름 입력'),
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              '알람 주기 설정',
              style: TextStyle(
                fontFamily: 'DoHyeon',
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            DropeddownButton(),
            SizedBox(
              height: 28.0,
            ),
            Text(
              '실수 색상 설정',
              style: TextStyle(
                fontFamily: 'DoHyeon',
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.pink;
                        },
                        buttonColor: selectedButton == Colours.pink
                            ? Colors.pink[50]
                            : Colors.pink,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.red;
                        },
                        buttonColor: selectedButton == Colours.red
                            ? Colors.red[50]
                            : Colors.red,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.orange;
                        },
                        buttonColor: selectedButton == Colours.orange
                            ? Colors.orange[50]
                            : Colors.orange,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.yellow;
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
                          selectedButton = Colours.green;
                        },
                        buttonColor: selectedButton == Colours.green
                            ? Colors.green[50]
                            : Colors.green,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.lightblue;
                        },
                        buttonColor: selectedButton == Colours.lightblue
                            ? Colors.lightBlue[50]
                            : Colors.lightBlue,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.blue;
                        },
                        buttonColor: selectedButton == Colours.blue
                            ? Colors.blueAccent[50]
                            : Colors.blueAccent,
                      ),
                      ColorButton(
                        onPress: () {
                          selectedButton = Colours.purple;
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
            SizedBox(
              height: 30.0,
            ),
          ]),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
