import 'package:daily_mistakes/pages/settingPage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/models/mistake.dart';

const bottomContainerHeight = 80.0;
const CardColour = Colors.blue;
const bottomContainerColour = Colors.yellow;
int currentTab = 0;
Widget currentScreen = MainPage();

List<Mistake> mistakes = [
  Mistake(name: 'first mistake', colour: Colors.red, alertPeriod: '하루에 3번'),
  Mistake(name: 'second mistake', colour: Colors.purple, alertPeriod: '하루에 5번'),
];

class MainPage extends StatefulWidget {
  static const String id = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    CalendarPage(),
    SettingPage(),
    StatisticPage(),
    OvercomePage(),
    MainPage(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromRGBO(255, 255, 246, 1),
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
                        fontFamily: 'DoHyeon',
                        fontWeight: FontWeight.bold,
                        ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        ),
                      onPressed: (){
                        Navigator.pushNamed(context, OvercomePage.id);
                      },
                    ),                    
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return MistakeCard(
                      mistakeName: mistakes[index].name,
                      colour: mistakes[index].colour,
                      count: mistakes[index].count,
                      countCallBack: (){
                        setState(() {
                          mistakes[index].countUp();
                        });
                      }
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
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>RegistrationScreen((newMistake){
              setState(() {
                mistakes.add(newMistake);
              });
            })
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(),
    );
  }
}