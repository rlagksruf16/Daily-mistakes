import 'package:daily_mistakes/pages/mistakeModifyPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/models/simpleMistake.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:daily_mistakes/pages/login.dart';

const bottomContainerHeight = 80.0;
const CardColour = Colors.blue;
const bottomContainerColour = Colors.yellow;
int currentTab = 0;
int allCount = 0;

int i = 0;

var now = new DateTime.now();
final year = now.year;
final month = now.month;
final day = now.day;
final today = '$year.$month.$day';

Widget currentScreen = MainPage();

List<SimpleMistake> sortedMistakes =
    List(); //통계 페이지에서 많이 한 실수들을 순서대로 표시하기 위해 사용
Comparator<SimpleMistake> countComparator =
    (a, b) => b.count.compareTo(a.count); //내림차순 sort에 사용

class MainPage extends StatefulWidget {
  static const String id = 'main_page';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController controller =
      ScrollController(); //홈버튼 누르면 맨 위로 이동하기 위해 사용
  final PageStorageBucket bucket = PageStorageBucket();
  FirebaseUser loggedInUser;
  String currentEmail;
  DocumentSnapshot snapshot;
  String currentName;
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

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
  void initState() {
    getCurrentUser();
    super.initState();
  }

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
                      '실수리스트',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontFamily: 'Title_Light',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        _auth.signOut();
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                        prefs.setBool('autoLogin', false);
                        prefs.setStringList('ID', ['', '']);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('Accounts')
                      .document(currentEmail)
                      .collection('mistakes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          final mistakeInfo = snapshot.data.documents[index];
                          print(mistakeInfo.data['name']);
                          final mistakeName = mistakeInfo.data['name'];
                          final colour = Color(
                              int.parse(mistakeInfo.data['colour'], radix: 16));
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
                                  .updateData({
                                'count': mistakeCount + 1,
                              });
                              await _firestore
                                  .collection('Accounts')
                                  .document(currentEmail)
                                  .collection('mistakes')
                                  .document(mistakeInfo.data['IDnum'])
                                  .collection('countTimeList')
                                  .document((mistakeCount + 1).toString())
                                  .setData({
                                'date': today,
                              });
                              todaysCount(DateTime.now().weekday);
                            },
                            onPressed: () {
                              //실수 카드 수정기능. 실수 이름 클릭시 실행
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MistakeModifyPage(
                                            beforeMistakeInfo: mistakeInfo,
                                          )));
                            },
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("No Mistakes!"),
                      );
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
            pageBuilder: (context, animation, secondaryAnimation) =>
                RegistrationScreen(docNum),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(controller),
    );
  }
}
