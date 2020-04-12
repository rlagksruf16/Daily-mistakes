import 'package:flutter/material.dart';

class Mistake{
  String name; //실수 카드 수정하려면 final을 지워야 해서 final 삭제.
  int id;
  Color colour;
  String alertPeriod;
  int count;
  List countTimeList = List();

  Mistake({this.name, this.id, this.colour, this.alertPeriod='하루에 1번', this.count = 0, });

  factory Mistake.fromMap(Map<String, dynamic> json) => new Mistake(
        name: json["name"],
        id: json["id"],
        colour: json["colour"],
        alertPeriod: json["alertPeriod"],
        count: json["count"],
        // countTimeList: json["countTimeList"],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'colour': colour,
      'alertPeriod': alertPeriod,
      'count': count,
      'countTimeList': countTimeList,
    };
  }
}
