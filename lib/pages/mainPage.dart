import 'package:daily_mistakes/pages/calendarPage.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:daily_mistakes/components/reusable_card.dart';
import 'package:daily_mistakes/pages/appBar.dart';
import 'package:daily_mistakes/pages/overcomePage.dart';

const bottomContainerHeight = 80.0;
const CardColour = Colors.blue;
const bottomContainerColour = Colors.yellow;


class MainPage extends StatefulWidget {
  static const String id = 'main_page';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

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
                        fontFamily: 'DoHyeon',
                        fontWeight: FontWeight.bold,
                        ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.list,
                        size: 30.0,
                        ),
                      onPressed: (){
                        Navigator.pushNamed(context, OvercomePage.id);
                      },
                    ),                    
                  ),
                ],
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              Container(
                child: ReusableCard(
                  colour: CardColour,
                ),
              ),
              
            ],      
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
              onPressed: () {
                Navigator.pushNamed(context, CalendarPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}



