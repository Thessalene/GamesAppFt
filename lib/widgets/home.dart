import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamesapp/models/games.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  List<Games> gameList = [
    Games("Tic Tac Toe", "assets/tic-tac-toe.png"),
    Games("Battleship", "assets/battleships.png"),
    Games("Hanged", "assets/hanging-rope.png"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: GridView.builder(
            itemCount: gameList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, i){
              return Card(
                elevation: 10.0,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(gameList[i].image, scale: 15.0,),
                      textTitleGame(gameList[i].name),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }

  Text textTitleGame(String gameName){
    return Text(
      gameName,
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14.0
      ),
    );
  }
}