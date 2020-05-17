import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EGamesType.dart';
import 'package:gamesapp/models/games.dart';
import 'package:gamesapp/widgets/hanged/hangedHomePage.dart';
import 'package:gamesapp/widgets/settings/gameConfiguration.dart';

class GameList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  List<Game> gameList = [
    Game(EGameType.TIC_TAC_TOE, "Tic Tac Toe", "assets/tic-tac-toe.png"),
    Game(EGameType.BATTLESHIP, "Battleship", "assets/battleships.png"),
    Game(EGameType.HANGED, "Hanged", "assets/hanging-rope.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: gameList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, i) {
            return InkWell(
              child: Card(
                elevation: 10.0,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset(
                        gameList[i].image,
                        scale: 15.0,
                      ),
                      textTitleGame(gameList[i].name),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext buildContext) {
                  var redirection;
                  switch (gameList[i].gameType) {
                    case EGameType.TIC_TAC_TOE:
                      redirection = HangedHomePage();
                      break;
                    case EGameType.BATTLESHIP:
                      redirection = null;
                      break;
                    case EGameType.HANGED:
                      redirection = null;
                      break;
                  }
                  return redirection;
                }));
              },
            );
          }),
    );
  }

  Text textTitleGame(String gameName){
    return Text(
      gameName,
      style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 14.0
      ),
    );
  }
}
