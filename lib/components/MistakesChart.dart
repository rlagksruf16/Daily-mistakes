import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'dart:math';

class MistakesChart extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
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
    } else if(nowWeekday == 2){
      nowWeek = DateTime(date.year, date.month, date.day - 1);
    } else if(nowWeekday == 3){
      nowWeek = DateTime(date.year, date.month, date.day - 2);
    } else if(nowWeekday == 4){
      nowWeek = DateTime(date.year, date.month, date.day - 3);
    } else if(nowWeekday == 5){
      nowWeek = DateTime(date.year, date.month, date.day - 4);
    } else if(nowWeekday == 6){
      nowWeek = DateTime(date.year, date.month, date.day - 5);
    } else{
      nowWeek = DateTime(date.year, date.month, date.day -6);
    }
    durationweek = DateTime(nowWeek.year, nowWeek.month, nowWeek.day + 6);
  }

  @override
  void initState() {
    checkMonday();
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
                      fontFamily: 'DoHyeon',
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
                        fontFamily: 'DoHyeon',
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
            y: 20,
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
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 7, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 2, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 8, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 12, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6, isTouched: i == touchedIndex);
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
                  TextStyle(color: Colors.yellow, fontFamily: 'DoHyeon'));
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

  BarChartData randomData() { //요일 별 어떤 실수를 한 건지 색으로 표현
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
            return makeGroupData(0, 15,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);

          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return null;
        }
      }),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(animDuration + Duration(milliseconds: 50));
    if (isPlaying) {
      refreshState();
    }
  }
}