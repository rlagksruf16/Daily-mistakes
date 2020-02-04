import 'package:flutter/material.dart';
import 'package:daily_mistakes/components/reusable_card.dart';
import 'package:daily_mistakes/pages/appBar.dart';

const bottomContainerHeight = 80.0;
const CardColour = Colors.grey;
const bottomContainerColour = Colors.yellow;

enum Gender{
  male,
  female,
}

class MainPage extends StatefulWidget {
  static const String id = 'main_page';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Gender selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.all(10.0),
                child: Text(
                  
                  '실수리스트',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    ),
                  textAlign: TextAlign.left,
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}



