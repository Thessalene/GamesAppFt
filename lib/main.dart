import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:gamesapp/widgets/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {return _MyAppState();}
}
/// SplashScreen Page
class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext builContext){
            return HomePage();
          }));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 400,
        ),
      ),
    );
  }

}
