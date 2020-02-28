import 'package:flutter/material.dart';

class Mistake{
  final String name;
  final Color colour;
  final String alertPeriod;
  int count;
  var countTime;
  List countTimeList = List();

  Mistake({this.name, this.colour, this.alertPeriod='하루에 1번', this.count = 0, this.countTime});

  void firstMistakeTime(){
    countTimeList.add(countTime);
  }

  void countUp(){
    count += 1;
    countTimeList.add(countTime);
  }

}