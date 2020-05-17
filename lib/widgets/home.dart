import 'package:flutter/material.dart';
import 'package:gamesapp/widgets/Bars/HomeScreenTopPart.dart';
import 'package:gamesapp/widgets/UI/gameList.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          GameList()
        ],
      ),
    );
  }
}
