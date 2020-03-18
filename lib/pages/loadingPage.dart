import 'package:flutter/material.dart';
import 'package:daily_mistakes/pages/mainPage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override

  void initState(){
    super.initState();
    getData();
  }

  void getData(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return MainPage();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //child:SpinKitPouringHourGlass(
      //    color: Colors.white,
      //    size:100.0,
      //  ),
    );
  }
}
