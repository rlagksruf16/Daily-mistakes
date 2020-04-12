import 'package:daily_mistakes/pages/mistakeModifyPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MistakeCard extends StatelessWidget {
  MistakeCard(
      {@required this.mistakeName,
      @required this.colour,
      @required this.count,
      this.countCallBack,
      this.onPressed});

  final String mistakeName;
  final Color colour;
  final int count;
  final Function countCallBack;
  final Function onPressed;

  static const mainTextStyle = TextStyle(
    fontSize: 25.0,
    fontFamily: 'Title_Light',
    //fontWeight: FontWeight.bold,
    color: Color(0xFFfdfdfd),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              '$count',
              style: mainTextStyle,
            ),
          ),
          Expanded(
            flex: 9,
            child: FlatButton(
              child: Text(
                mistakeName,
                style: mainTextStyle,
              ),
              onPressed: onPressed,
            ),
          ),
          RoundIconButton(
            onPressed: countCallBack, //count++
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 90.0,
      padding: EdgeInsets.fromLTRB(20, 20, 15, 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            offset: Offset(
              3.0, // horizontal, move right 10
              3.0, // vertical, move down 10
            ),
          ),
        ],
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        FontAwesomeIcons.plus,
        color: Color(0xFFfdfdfd),
      ),
      onPressed: onPressed,

      constraints: BoxConstraints.tightFor(
        width: 30.0,
        height: 30.0,
      ),
      shape: CircleBorder(),

      elevation: 0.0,
      //단색으로 지정? 투명도로 카드색깔 비추게? -> 그러면 카드마다 +색깔 달라짐
      fillColor: Color.fromRGBO(128, 128, 128, 0),
    );
  }
}
