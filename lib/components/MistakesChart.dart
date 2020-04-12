import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:daily_mistakes/models/mistake.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:daily_mistakes/pages/statisticPage.dart';
import 'dart:async';
import 'dart:math';

double mondayCount = 0;
double tuesdayCount = 0;
double wednesdayCount = 0;
double thursdayCount = 0;
double fridayCount = 0;
double saturdayCount = 0;
double sundayCount = 0;
double maxMistakes = 0;

void todaysCount(int day) {
  if (day == 1) {
    if (sundayCount != 0 ||
        mondayCount != 0 ||
        tuesdayCount != 0 ||
        wednesdayCount != 0 ||
        thursdayCount != 0 ||
        fridayCount != 0 ||
        saturdayCount != 0) {
      //매주 월요일 마다 갱신
      mondayCount = 0;
      tuesdayCount = 0;
      wednesdayCount = 0;
      thursdayCount = 0;
      fridayCount = 0;
      saturdayCount = 0;
      sundayCount = 0;
      maxMistakes = 0;
    }
    mondayCount++;
    if (mondayCount >= maxMistakes) {
      maxMistakes = mondayCount;
    }
  } else if (day == 2) {
    tuesdayCount++;
    if (tuesdayCount >= maxMistakes) {
      maxMistakes = tuesdayCount;
    }
  } else if (day == 3) {
    wednesdayCount++;
    if (wednesdayCount >= maxMistakes) {
      maxMistakes = wednesdayCount;
    }
  } else if (day == 4) {
    thursdayCount++;
    if (thursdayCount >= maxMistakes) {
      maxMistakes = thursdayCount;
    }
  } else if (day == 5) {
    fridayCount++;
    if (fridayCount >= maxMistakes) {
      maxMistakes = fridayCount;
    }
  } else if (day == 6) {
    saturdayCount++;
    if (saturdayCount >= maxMistakes) {
      maxMistakes = saturdayCount;
    }
  } else {
    sundayCount++;
    if (sundayCount >= maxMistakes) {
      maxMistakes = sundayCount;
    }
  }
}

class MistakesChart extends StatefulWidget {
  final List<Color> availableColors = [
    Color(0xFFFF7187),
    Color(0xFFF17171),
    Color(0xFFFD9644),
    Color(0xFFFFDF6F),
    Color(0xFF57C9AE),
    Color(0xFF9CE8EE),
    Color(0xFF5D9CEC),
    Color(0xFFD6BBFF),
  ];

  @override
  State<StatefulWidget> createState() => MistakesChartState();
}

class MistakesChartState extends State<MistakesChart> {
  final Color barBackgroundColor = Colors.blueGrey[200];
  final Duration animDuration = Duration(milliseconds: 250);

  int touchedIndex;
  bool isPlaying = false;

  static DateTime date = DateTime.now();
  int nowWeekday = date.weekday;
  DateTime nowWeek;
  int overday = 0;
  DateTime durationweek;

  void checkMonday() {
    if (nowWeekday == 1) {
      nowWeek = DateTime.now();
    } else if (nowWeekday == 2) {
      nowWeek = DateTime(date.year, date.month, date.day - 1);
    } else if (nowWeekday == 3) {
      nowWeek = DateTime(date.year, date.month, date.day - 2);
    } else if (nowWeekday == 4) {
      nowWeek = DateTime(date.year, date.month, date.day - 3);
    } else if (nowWeekday == 5) {
      nowWeek = DateTime(date.year, date.month, date.day - 4);
    } else if (nowWeekday == 6) {
      nowWeek = DateTime(date.year, date.month, date.day - 5);
    } else {
      nowWeek = DateTime(date.year, date.month, date.day - 6);
    }
    durationweek = DateTime(nowWeek.year, nowWeek.month, nowWeek.day + 6);
  }

  @override
  void initState() {
    checkMonday();
    bestMistakesChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.blueGrey,
        elevation: 10,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '일주일 간 실수 통계',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Title_Light',
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatDate(nowWeek, [yyyy, '_', mm, '_', dd]) +
                        ' ~ ' +
                        formatDate(durationweek, [yyyy, '_', mm, '_', dd]),
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Title_Light',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              //재생버튼
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    //요일 별 데이타 저장
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 23,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxMistakes > 10 ? maxMistakes : 10,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          //요일 별 횟수 저장. x는 요일 인덱스, y는 실수 횟수
          case 0:
            return makeGroupData(0, mondayCount, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, tuesdayCount, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, wednesdayCount,
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, thursdayCount,
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, fridayCount, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, saturdayCount,
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, sundayCount, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        //손으로 눌렀을 때 반응
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(
                  weekDay + '\n' + (rod.y.toInt() - 1).toString() + '번',
                  TextStyle(color: Colors.yellow, fontFamily: 'Title_Light'));
            }),
        touchCallback: (barTouchResponse) {
          //손댔는지 확인
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(), //저장해논 요일 별 데이터들
    );
  }

  BarChartData randomData() {
    //요일 별 어떤 실수를 한 건지 색으로 표현
    //재생 버튼 눌렀을 때
    return BarChartData(
      barTouchData: const BarTouchData(
        enabled: false, //손댔을 때 반응 없음
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return mondayCount != 0
                ? makeGroupData(
                    0, Random().nextInt(mondayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);

          case 1:
            return tuesdayCount != 0
                ? makeGroupData(
                    1, Random().nextInt(tuesdayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          case 2:
            return wednesdayCount != 0
                ? makeGroupData(
                    2, Random().nextInt(wednesdayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          case 3:
            return thursdayCount != 0
                ? makeGroupData(
                    3, Random().nextInt(thursdayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          case 4:
            return fridayCount != 0
                ? makeGroupData(
                    4, Random().nextInt(fridayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          case 5:
            return saturdayCount != 0
                ? makeGroupData(
                    5, Random().nextInt(saturdayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          case 6:
            return sundayCount != 0
                ? makeGroupData(
                    6, Random().nextInt(sundayCount.toInt()).toDouble(),
                    barColor: widget.availableColors[
                        Random().nextInt(widget.availableColors.length)])
                : makeGroupData(0, 0, barColor: Colors.black);
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + Duration(milliseconds: 300));
    if (isPlaying) {
      refreshState();
    }
  }
}
