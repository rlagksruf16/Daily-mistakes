import 'package:flutter/material.dart';

class Mistake{
  String name; //실수 카드 수정하려면 final을 지워야 해서 final 삭제.
  int id;
  Color colour;
  String alertPeriod;
  int count;
  var countTime;
  List countTimeList = List();

  Mistake({this.name, this.id, this.colour, this.alertPeriod='하루에 1번', this.count = 0, this.countTime});

  void firstMistakeTime(){
    countTimeList.add(countTime);
  }

  void countUp(){
    count += 1;
    countTimeList.add(countTime);
  }
}
