import 'package:flutter/material.dart';

class Mistake{
  String name; //실수 카드 수정하려면 final을 지워야 해서 final 삭제.
  int id;
  Color colour;
  String alertPeriod;
  int count;
  List countTimeList = List();

  Mistake({this.name, this.colour, this.alertPeriod='하루에 1번', this.count = 0, this.countTimeList});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'colour': colour,
      'alertPeriod': alertPeriod,
      'count': count,
      'countTimeList': countTimeList,
    };
  }
}
