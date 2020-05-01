import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'Login_page';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  String _errorMessage;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: _signInWithGoogle,
            child: const Text('Continue with Google'),
          ),
          if(_errorMessage != null) Text(
            _errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    ),
  );
  void _signInWithGoogle() async {
    _setLoggingIn();
    String errMsg;
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, 
        accessToken: googleAuth.accessToken,
      );
      await _auth.signInWithCredential(credential);
    } catch(e) {
      errMsg = 'Login에 실패했습니다. 다시 시도해보세요';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }
  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if(mounted) {
      setState(() {
        loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }
}