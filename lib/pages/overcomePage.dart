import 'package:flutter/material.dart';
import 'package:daily_mistakes/components/mistake_card.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/pages/mainPage.dart';



const CardColour = Colors.white;
List<Mistake> overcomeMistakes = [
  Mistake(name: 'first overcome', colour: Color(0xFFF17171), alertPeriod: '하루에 3번', countTime: DateTime.now()),
  Mistake(name: 'second overcome', colour: Color(0xFFFFDF6F), alertPeriod: '하루에 5번', countTime: DateTime.now()),
];

class OvercomePage extends StatefulWidget {
  static const String id = 'overcome_page';

  @override
  _OvercomePageState createState() => _OvercomePageState();
}

class _OvercomePageState extends State<OvercomePage> {
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
                          fontFamily: 'DoHyeon',
                          fontWeight: FontWeight.bold,
                          ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index){
                      return MistakeCard(
                        mistakeName: overcomeMistakes[index].name,
                        colour: CardColour,
                        count: overcomeMistakes[index].count,
                        countCallBack: (){
                          setState(() {
                            overcomeMistakes[index].countTime = DateTime.now();
                            overcomeMistakes[index].countUp();
                            print(overcomeMistakes[index].countTimeList);
                          });
                        }
                      );
                    },
                    itemCount: overcomeMistakes.length,
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