import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
        (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext builContext){
            //return Home();
          }));
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
