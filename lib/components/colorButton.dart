import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  ColorButton({
    @required this.buttonColor,
    @required this.onPress,
  });

  final Color buttonColor;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      
      child: Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
