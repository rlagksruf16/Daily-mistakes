import 'package:flutter/material.dart';

Future alertPopup(BuildContext context, int number) {
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Alert!'),
          content: number == 1? Text('Write mistake name.'): Text('Choose one color.'),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: (){
                Navigator.pop(context);
                }
              ),
          ],
        );
      }
    );
  }