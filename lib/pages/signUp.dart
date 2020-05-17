import 'package:daily_mistakes/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:daily_mistakes/components/containerBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

const Color mainColor = Colors.blueGrey;

class SignUpPage extends StatefulWidget {
  static const id = 'signUp_page';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String passwrd;
  String chkPassword;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: 120.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Text('회원가입',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    SizedBox(height: 10.0),
                    Container(
                      //이메일 입력
                      height: 550,
                      child: ContainerBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '메일',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: '이메일 입력하세요',
                                hintStyle: TextStyle(
                                  color: mainColor,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: mainColor,
                                  size: 30,
                                ),
                              ),
                              key: Key('email'),
                              validator: (value) {
                                if (!EmailValidator.validate(value, true)) {
                                  return '이메일 형태가 아닙니다';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            // 비밀번호
                            Text(
                              '비밀번호',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 20,
                              ),
                              key: Key('password'),
                              validator: (value) {
                                if (value.length < 6) {
                                  return '6자리 이상 입력하세요!';
                                }
                                return null;
                              },
                              obscureText: true,
                              onChanged: (value) {
                                passwrd = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: mainColor,
                                  size: 30,
                                ),
                                hintText: 'Write password.',
                                hintStyle: TextStyle(
                                  color: mainColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            // 비밀번호 확인
                            Text(
                              '비밀번호 확인',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 20,
                              ),
                              validator: (value) {
                                return (passwrd != value)
                                    ? '비밀번호가 맞지 않아요!'
                                    : null;
                              },
                              obscureText: true,
                              onChanged: (value) {
                                chkPassword = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: mainColor,
                                  size: 30,
                                ),
                                hintText: '비밀번호 다시 입력해주세요',
                                hintStyle: TextStyle(
                                  color: mainColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.topRight,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              //제출 버튼
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
                                      final newUser = await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: passwrd);
                                      if (newUser != null) {
                                        _firestore
                                            .collection('Accounts')
                                            .document(email)
                                            .setData({
                                          'email': email,
                                        });
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                content: Text("회원가입 성공했어요 ^^ "),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("확인"),
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    } catch (e) {
                                      //에러컨트롤
                                      print(e);
                                      showDialog(
                                          //중복확인
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              content: Text("이미 존재해요!"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("확인"),
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
                                  '회원가입',
                                  style: TextStyle(
                                    color: mainColor,
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
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
