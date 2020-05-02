import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:daily_mistakes/components/containerBox.dart';
import 'package:daily_mistakes/pages/signUp.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String reEmail;
  String password;
  bool showSpinner = false;
  bool autologin = false;

  final _formKey = GlobalKey<FormState>();
  final _formKeySecond = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isAutoLogin = prefs.getBool('autoLogin');
    final List<String> savedUserInfo = prefs.getStringList('ID');

    setState(() {
      showSpinner = true;
    });
    if (isAutoLogin == true) {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: savedUserInfo[0], password: savedUserInfo[1]);
        if (user != null) {
          Navigator.pushReplacementNamed(context, MainPage.id);
        }
      } catch (e) {
        print(e);
      }
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    autoLogIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        // backgroundColor: Colors.blueGrey,
        body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            color: Colors.white70,
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
        //빈공간 
                    SizedBox(height: 50.0),
        // 로그인
                    Text('로그인',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    SizedBox(height: 10.0),
        //이메일 입력
                    Container(
                      height: 550,
                      child: ContainerBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '아이디(E-mail)',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: '아이디 입력하세요',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blueGrey,
                                  size: 30,
                                ),
                              ),
                              key: Key('email'),
                              validator: (value) {
                                if (!EmailValidator.validate(value, true)) {
                                  return 'wrong E-mail address format.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
            // 빈 공간
                            SizedBox(
                              height: 30.0,
                            ),
            // 비밀번호
                            Text(
                              '비밀번호',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                              ),
                              key: Key('password'),
                              validator: (value) {
                                if (value.length < 6) {
                                  return 'write more than 6 words.';
                                }
                                return null;
                              },
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.blueGrey,
                                  size: 30,
                                ),
                                hintText: '비밀번호 입력하세요',
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
        // 빈 공간 
                            SizedBox(
                              height: 20.0,
                            ),
        //자동 로그인 체크
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0.0),
                              child: Row(
                                children: <Widget>[
                                  Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.black),
                                    child: Checkbox(
                                      value: autologin,
                                      checkColor: Colors.white,
                                      activeColor: Colors.blueGrey,
                                      onChanged: (value) {
                                        setState(() {
                                          autologin = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    '자동로그인',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //회원가입하기
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.topRight,
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, SignUpPage.id);
                                      },
                                      padding: EdgeInsets.only(left: 90.0),
                                      child: Text(
                                        '회원가입',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //비밀번호 찾기
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Form(
                                          key: _formKeySecond,
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            content: new TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              key: Key('reEmail'),
                                              validator: (value) {
                                                if (!EmailValidator.validate(
                                                    value, true)) {
                                                  return 'wrong E-mail address format.';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                reEmail = value;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: 'E-mail'),
                                            ),
                                            actions: <Widget>[
                                              new FlatButton(
                                                child: new Text("confirm"),
                                                onPressed: () async {
                                                  if (_formKeySecond
                                                      .currentState
                                                      .validate()) {
                                                    setState(() {
                                                      showSpinner = true;
                                                    });
                                                    try {
                                                      await _auth
                                                          .sendPasswordResetEmail(
                                                              email: reEmail);
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              content: Text(
                                                                  "Check the E-mail address."),
                                                              actions: <Widget>[
                                                                new FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "confirm"),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    } catch (e) {
                                                      print(e);
                                                      Navigator.pop(context);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              content: Text(
                                                                  "Do not exist the account."),
                                                              actions: <Widget>[
                                                                new FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      "confirm"),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    }
                                                    setState(() {
                                                      showSpinner = false;
                                                    });
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                padding: EdgeInsets.only(right: 9.0),
                                child: Text(
                                  '비밀번호를 까먹었어요',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //로그인 버튼
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: 400,
                              child: RaisedButton(
                                elevation: 5.0,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      final user = await _auth
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      if (user != null) {
                                        Navigator.pushReplacementNamed(
                                            context, MainPage.id);
                                        prefs.setBool('autoLogin', autologin);
                                        if (autologin) {
                                          prefs.setStringList(
                                              'ID', [email, password]);
                                        } else {
                                          prefs.setStringList('ID', ['', '']);
                                        }
                                      }
                                    } catch (e) {
                                      print(e);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              content: Text(
                                                  "Check the E-mail and Password."),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Confirm"),
                                                )
                                              ],
                                            );
                                          });
                                    }
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  }
                                },
                                padding: EdgeInsets.all(20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    letterSpacing: 2,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
