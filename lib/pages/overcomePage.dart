import 'package:flutter/material.dart';
import 'package:daily_mistakes/components/reusable_card.dart';

const CardColour = Colors.white;

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
    );
  }
}