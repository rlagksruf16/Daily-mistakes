import 'package:flutter/material.dart';
import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
import 'dart:math';

class OvercomePage extends StatefulWidget {
  static const String id = 'overcome_page';

  @override
  _OvercomePageState createState() => _OvercomePageState();
}

class _OvercomePageState extends State<OvercomePage> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String currentEmail;  
  DocumentSnapshot snapshot;
  String currentName;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        currentEmail = loggedInUser.email;
        snapshot = await _firestore
            .collection('Accounts')
            .document(currentEmail)
            .get();
        setState(() {
          currentName = snapshot.data['name'];
        });
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
      body: Container(
        color: Colors.white,
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
                        '극복리스트',
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
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Accounts')
                      .document(currentEmail)
                      .collection('overcomeMistakes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          final mistakeInfo = snapshot.data.documents[index];
                          final mistakeName = mistakeInfo.data['name'];
                          final colour = Color(int.parse(mistakeInfo.data['colour'], radix: 16));
                          final mistakeCount = mistakeInfo.data['count'];
                          return MistakeCard(
                            mistakeName: mistakeName,
                            colour: colour,
                            count: mistakeCount,
                            countCallBack: () async {
                              await _firestore
                              .collection('Accounts')
                              .document(currentEmail)
                              .collection('mistakes')
                              .document(mistakeInfo.data['IDnum'])
                              .setData({
                                'name': mistakeInfo.data['name'],
                                'count': 0,
                                'colour': mistakeInfo.data['colour'],
                                'alertPeriod': mistakeInfo.data['alertPeriod'],
                                'IDnum': mistakeInfo.data['IDnum'],
                              });
                              await _firestore
                              .collection('Accounts')
                              .document(currentEmail)
                              .collection('overcomeMistakes')
                              .document(mistakeInfo.data['IDnum'])
                              .delete();
                              setState(()  {
                                print('aaaaaa');
                                todaysCount(
                                    DateTime.now().weekday); //요일별로 총 실수횟수 저장을 위해 사용
                                sortedMistakes.sort(countComparator); //실수 횟수 별로 저장하기 위해 사용
                              });
                            },
                            onPressed: () {},
                          );
                        },
                        
                      );
                    } else {
                      return Center(child:Text("No Mistakes!"),);
                    }
                  },
                ),
                ),
                
              ],      
            ),
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomActionButton(
        icon: Icon(Icons.add),
        onPressed: () {
          var docNum = (Random().nextInt(10000) + 1).toString();
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen(docNum),
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
          ),
        );
      },),
      bottomNavigationBar: CustomAppBar(null),
    );
  }
}