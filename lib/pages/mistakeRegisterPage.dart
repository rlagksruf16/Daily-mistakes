import 'package:flutter/material.dart';

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


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email;
  String password;
  Colours selectedButton = Colours.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // inAsyncCall: showSpinner,
        padding: EdgeInsets.only(top: 100.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('실수 이름 입력'),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: '실수 입력'),
              ),
              SizedBox(
                height: 28.0,
              ),
              Text('알람 주기 설정'),
              SizedBox(
                height: 8.0,
              ),
              DropeddownButton(
                onChanged: (String newValue) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 28.0,
              ),
              Text('실수 색상 설정'),
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
                          buttonColor: selectedButton == Colours.pink ? Colors.pink[50] : Colors.pink,
                          ),
                        ColorButton(
                         onPress: () {
                            setState(() {
                              selectedButton = Colours.red;
                            });
                          },
                          buttonColor: selectedButton==Colours.red ? Colors.red[50] : Colors.red,
                        ),
                        ColorButton(
                         onPress: () {
                            setState(() {
                              selectedButton = Colours.orange;
                            });
                          },
                          buttonColor: selectedButton==Colours.orange ? Colors.orange[50] : Colors.orange,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                             selectedButton = Colours.yellow;
                            });
                          },
                          buttonColor: selectedButton==Colours.yellow ? Colors.yellow[50] : Colors.yellow,
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
                          buttonColor: selectedButton==Colours.green ? Colors.green[50] : Colors.green,
                          ),
                        ColorButton(
                           onPress: () {
                            setState(() {
                              selectedButton = Colours.lightblue;
                            });
                          },
                          buttonColor: selectedButton==Colours.lightblue ? Colors.lightBlue[50]: Colors.lightBlue,
                        ),
                        ColorButton(
                         onPress: () {
                            setState(() {
                              selectedButton = Colours.blue;
                            });
                          },
                          buttonColor: selectedButton==Colours.blue ? Colors.blueAccent[50] : Colors.blueAccent,
                        ),
                        ColorButton(
                          onPress: () {
                            setState(() {
                             selectedButton = Colours.purple;
                            });
                          },
                          buttonColor: selectedButton==Colours.purple ? Colors.purple[50] : Colors.purple,
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
                colour: Colors.grey,
                onPressed: () {},
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
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class DropeddownButton extends StatefulWidget {
  DropeddownButton({@required this.onChanged});

  final Function onChanged;

  @override
  _DropeddownButtonState createState() => _DropeddownButtonState();
}

class _DropeddownButtonState extends State<DropeddownButton> {
  String firstvalue = '하루에 1번';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: firstvalue,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.grey,
      ),
      onChanged: widget.onChanged,
      items: <String>['하루에 1번', '하루에 2번', '하루에 3번', '하루에 5번']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.colour, @required this.onPressed,});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  ColorButton({@required this.onPress, @required this.buttonColor,});

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
        // height: kBottomContainerHeight,
      ),
    );
  }
}

// initialRoute: RegistrationScreen.id,
// routes: {
//   RegistrationScreen.id: (context) => RegistrationScreen(),
// },