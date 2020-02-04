import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReusableCard extends StatefulWidget {
  ReusableCard({@required this.colour});
  final Color colour;

  @override
  _ReusableCardState createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  static const mainTextStyle = TextStyle(
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '20',
              style: mainTextStyle,
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              '새벽 4시에 잤다.',
              style: mainTextStyle,
            ),
          ),
          RoundIconButton(
            onPressed:(){
              setState(() {
                //count++;
              });
            }
          ),
        ],
      ),
      margin: EdgeInsets.all(10.0),
      height: 70.0,
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.black,
        //color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget{
  
  RoundIconButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context){
    return RawMaterialButton(
      child: Icon(FontAwesomeIcons.plus,),
      onPressed: onPressed,
      elevation: 3.0,
      constraints: BoxConstraints.tightFor(
        width: 30.0,
        height: 30.0,
      ),
      shape: CircleBorder(),
      fillColor: Color.fromRGBO(128, 128, 128, 0),
    );
  }
}


