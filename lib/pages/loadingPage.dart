import 'package:daily_mistakes/pages/startPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:daily_mistakes/pages/signUp.dart';
import 'package:daily_mistakes/pages/login.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:daily_mistakes/models/simpleMistake.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadingPage extends StatefulWidget {
  static const String id = 'loading_page';

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void makeSortedList() async{
    final _firestore = Firestore.instance;
    final _auth = FirebaseAuth.instance;
    await _firestore.collection('mistakes').getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f){
        setState(() {
           sortedMistakes.add(SimpleMistake(
            name: f.data['name'],
            colour: Color(int.parse(f.data['colour'],radix: 16)),
            count: f.data['count'],
          ));
        });
      });
    });
    if(sortedMistakes.length > 0){
      setState(() {
        sortedMistakes.sort(countComparator);
      });
    }
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new StartPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    makeSortedList();
    
    new Timer(new Duration(milliseconds: 400), () {
      checkFirstSeen();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Loading...'),
      ),
    );
  }
}
