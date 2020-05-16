import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:gamesapp/sqflite/database_client.dart';
import 'dart:async';
import 'package:gamesapp/widgets/home.dart';
import 'package:quiver/strings.dart';

ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFFF37918),
  fontFamily: 'Oxygen',
);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

/// SplashScreen Page
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      //If database is empty
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext buildContext) {
        return HomeScreen();
      }));
    });
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
