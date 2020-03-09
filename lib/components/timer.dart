import 'package:flutter/material.dart';
import 'dart:async';
import 'package:daily_mistakes/models/mistake.dart';

int i=0;

void startTimer(List<Mistake> mistakes, Function moveMistake) {
  Timer timer = new Timer.periodic(Duration(seconds: 300), (time) {
    for (var mistake in mistakes) {
      if (mistake.count > 0) {
        Duration difference = mistake.countTimeList[mistake.count]
            .difference(mistake.countTimeList[mistake.count - 1]);
        if (difference.inMinutes >= 1) {
          print(difference.inMinutes);

          moveMistake(mistakes.indexOf(mistake));
        }
      }
    }
    print('Something $i');
    print(DateTime.now());
    i++;
  });
}