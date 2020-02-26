import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  static const String id = 'setting_Page';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  


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
                        '환경설정',
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
                /*
                Container(
                  child: MistakeCard(
                    colour: CardColour,
                  ),
                ),
                Container(
                  child: MistakeCard(
                    colour: CardColour,
                  ),
                ),
                
                */
              ],      
            ),
          ),
      ),
    );
  }
}