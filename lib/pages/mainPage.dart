import 'dart:async';
import 'package:daily_mistakes/pages/mistakeModifyPage.dart';
import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/pages/mistakeModifyPage.dart' as Mod;
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
//import 'package:daily_mistakes/components/pushNotification.dart';
//import 'package:daily_mistakes/components/timer.dart';

const bottomContainerHeight = 80.0;
const CardColour = Colors.blue;
const bottomContainerColour = Colors.yellow;
int currentTab = 0;
int allCount = 0;

int i=0;

var now = new DateTime.now();
final year = now.year;
final month = now.month;
final day = now.day;
final today = '$year.$month.$day';

Widget currentScreen = MainPage();

Mistake mistake;
List<Mistake> mistakes = List();
List<Mistake> sortedMistakes = List(); //통계 페이지에서 많이 한 실수들을 순서대로 표시하기 위해 사용
List<Mistake> overcomeMistakes = List();
Comparator<Mistake> countComparator =
    (a, b) => b.count.compareTo(a.count); //내림차순 sort에 사용

class MainPage extends StatefulWidget {
  static const String id = 'main_page';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController controller = ScrollController();//홈버튼 누르면 맨 위로 이동하기 위해 사용
  final PageStorageBucket bucket = PageStorageBucket();
  
  void startTimer(List<Mistake> mistakes) {
    Timer timer = Timer.periodic(Duration(days: 1), (time) => setState((){
      for (var mistake in mistakes) {
        List lastDay = mistake.countTimeList[mistake.count].split('.');
        var lastTap = DateTime.utc(int.parse(lastDay[0]),int.parse(lastDay[1]),int.parse(lastDay[2]));
        lastTap.add(Duration(hours: 9));
        print('TAP $lastTap');
        lastTap.toLocal();
       Duration differenceTime = DateTime.now().difference(lastTap);
        if (mistakes.length!=0 && differenceTime.inDays >= 1) {
          overcomeMistakes.add(mistake);
          mistakes.remove(mistake);
        }
      }
      print('Something $i');
      print(DateTime.now());
      i++;
    })
    );
  }

  @override
  void initState(){
    super.initState();
    startTimer(mistakes);
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
                        Icons.settings,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SettingPage.id);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemBuilder: (context, index) {
                    return MistakeCard(
                      mistakeName: mistakes[index].name,
                      colour: mistakes[index].colour,
                      count: mistakes[index].count,
                      countCallBack: () {
                        setState(() {
                          mistakes[index].count += 1;
                          mistakes[index].countTimeList.add(today);
                          // print('countTimeList ${mistakes[index].countTimeList}');
                          todaysCount(
                              DateTime.now().weekday); //요일별로 총 실수횟수 저장을 위해 사용
                          sortedMistakes
                              .sort(countComparator); //실수 횟수 별로 저장하기 위해 사용
                        });
                      },
                      onPressed: () {
                        //실수 카드 수정기능. 실수 이름 클릭시 실행
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MistakeModifyPage(
                                      beforeMistake: mistakes[index],
                                    )));
                      },
                    );
                  },
                  itemCount: mistakes.length,
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
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen((newMistake) {
                      setState(() {
                        mistakes.add(newMistake);
                        sortedMistakes.add(newMistake);
                      });
                    }),
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
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(controller),
    );
  }
}