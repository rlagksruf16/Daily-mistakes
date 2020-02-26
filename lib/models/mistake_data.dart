import 'package:flutter/material.dart';
import 'package:daily_mistakes/models/mistake.dart';

class MistakeData extends ChangeNotifier{

  List<Mistake> mistakes = [
    Mistake(name: 'first mistake', colour: Colors.red, alertPeriod: '하루에 3번'),
    Mistake(name: 'second mistake', colour: Colors.purple, alertPeriod: '하루에 5번'),
  ];

  int get mistakeCount{
    return mistakes.length;
  }
}