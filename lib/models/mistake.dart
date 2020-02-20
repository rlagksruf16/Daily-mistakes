import 'package:flutter/material.dart';

class Mistake{
  final String name;
  final Color colour;
  final String alertPeriod;
  int count;

  Mistake({this.name, this.colour, this.alertPeriod, this.count = 0});

  void countUp(){
    count += 1;
  }

}