import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:daily_mistakes/components/containerBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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
        backgroundColor: Colors.yellow,
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
                    Text('회원가입',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                    Container(
                      //이메일 입력
                      height: 175,
                      child: ContainerBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '메일',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Write e-mail.',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              key: Key('email'),
                              validator: (value) {
                                if (!EmailValidator.validate(value, true)) {
                                  return 'It\'s not email format.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //비밀번호 입력
                      height: 175,
                      child: ContainerBox(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              key: Key('password'),
                              validator: (value) {
                                if (value.length < 6) {
                                  return 'Write more than 6 letters.';
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
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                hintText: 'Write password.',
                                hintStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container( //비밀번호 확인
                        height: 175,
                        child: ContainerBox(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Confirm password',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                validator: (value) {
                                  return (passwrd != value)
                                      ? 'Password do not match.'
                                      : null;
                                },
                                obscureText: true,
                                onChanged: (value) {
                                  chkPassword = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  hintText: 'Please enter your password again.',
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container( //제출 버튼
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: 200,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
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
                                                  BorderRadius.circular(10)),
                                          content: Text("Success"),
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
                              } catch (e) { //에러컨트롤
                                print(e);
                                showDialog( //중복확인
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        content: Text("This account already exists."),
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
                            'Submit',
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 2,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
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
