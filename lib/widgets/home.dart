import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EGamesType.dart';
import 'package:gamesapp/models/games.dart';
import 'package:gamesapp/widgets/gameConfiguration.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{

  List<Game> gameList = [
    Game(EGameType.TIC_TAC_TOE,"Tic Tac Toe", "assets/tic-tac-toe.png"),
    Game(EGameType.BATTLESHIP, "Battleship", "assets/battleships.png"),
    Game(EGameType.HANGED, "Hanged", "assets/hanging-rope.png"),
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
              return InkWell(
                child: Card(
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
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext buildContext){
                      return GameConfiguration(gameList[i].gameType);
                    }
                  ));
                },
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