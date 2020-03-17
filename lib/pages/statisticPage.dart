import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:daily_mistakes/components/CustomActionButton.dart';
import 'package:daily_mistakes/components/CustomAppBar.dart';
import 'package:daily_mistakes/components/MistakesChart.dart';
import 'package:daily_mistakes/pages/mistakeRegisterPage.dart';
import 'package:daily_mistakes/models/mistake.dart';

List<Mistake> bestMistakes = List();
List<Color> colorList = List();
Map<String, double> dataMap = Map();

void bestMistakesChart() {
  bestMistakes = List();
  colorList = List();
  dataMap = Map();
  if (sortedMistakes.length <= 4) {
    if (sortedMistakes.isEmpty) {
      colorList.add(Colors.blueGrey[200]);
      dataMap.putIfAbsent("No Data", () => 1);
    }
    for (var mistake in sortedMistakes) {
      bestMistakes.add(mistake);
      colorList.add(mistake.colour);
    }
  } else {
    for (int i = 0; i < 4; i++) {
      bestMistakes.add(sortedMistakes[i]);
      colorList.add(sortedMistakes[i].colour);
    }
  }
  bestMistakes.forEach((Mistake mistakes) {
    print('${mistakes.name}');
  });
}

class StatisticPage extends StatefulWidget {
  static const String id = 'static_screen';

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      '실수 통계',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontFamily: 'DoHyeon',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: MistakesChart(),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: BestMistakesChart(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomActionButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RegistrationScreen((newMistake) {
                      setState(() {
                        mistakes.add(newMistake);
                        sortedMistakes.add(newMistake);
                      });
                    }),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        },
      ),
      bottomNavigationBar: CustomAppBar(null),
    );
  }
}

class BestMistakesChart extends StatefulWidget {
  @override
  _BestMistakesChartState createState() => _BestMistakesChartState();
}

class _BestMistakesChartState extends State<BestMistakesChart> {
  // Map<String, double> dataMap = Map();
  //   sortedMistakes.forEach((Mistake mistakes) {
  //   print('${mistakes.name} , ${mistakes.colour}');
  // });

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < bestMistakes.length; i++) {
      dataMap.putIfAbsent(
          "${bestMistakes[i].name}", () => bestMistakes[i].count.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.blueGrey,
        elevation: 10,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: pie.PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 42.0,
              chartRadius: MediaQuery.of(context).size.width / 2.7,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.grey[200],
              colorList: colorList,
              showLegends: true,
              legendPosition: pie.LegendPosition.right,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: pie.defaultChartValueStyle.copyWith(
                color: Colors.blueGrey[900].withOpacity(0.9),
              ),
              chartType: pie.ChartType.ring,
            ),
          ),
        ),
      ),
    );
  }
}
