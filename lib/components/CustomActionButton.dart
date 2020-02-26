import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  @override

  CustomActionButton({@required this.icon, @required this.onPressed });

  final Icon icon;
  final Function onPressed;


  Widget build(BuildContext context) {
    return Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: icon,
            onPressed: onPressed,
            backgroundColor: Color(0xFF5f80f4),
          ),
        ),
      );
  }
}