import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  static const String id = 'loading_page';
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override

  void initState(){
    super.initState();
    getData();
  }

  void getData() async {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return MainPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size:100.0,
        ),
      ),
      
    );
  }
}
