import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EDifficultyType.dart';
import 'package:gamesapp/models/score.dart';
import 'package:gamesapp/models/tictactoe_tiles.dart';
import 'package:quiver/iterables.dart';


class TicTacToe extends StatefulWidget{
  final List<Score> playerList;
  final EDifficultyType difficultyType;
  int numberTiles = 9;
  int crossAxisCount = 3;
  List<TicTacToeTiles> tilesList;

  TicTacToe(this.difficultyType, this.playerList);

  @override
  State<StatefulWidget> createState() {

    print("DIFFICULTY TIC TAC TOE : ${difficultyType.toString()}");
    switch(difficultyType){
      case EDifficultyType.EASY:
        numberTiles = 9;
        crossAxisCount = 3;
        break;
      case EDifficultyType.MEDIUM:
        numberTiles = 16;
        crossAxisCount = 4;
        break;
      case EDifficultyType.DIFFICULT:
        numberTiles = 25;
        crossAxisCount = 5;
        break;
      case EDifficultyType.EXPERT:
        numberTiles = 36;
        crossAxisCount = 6;
        break;
    }
    generatePositionWinList();

    tilesList = List<TicTacToeTiles>.generate(numberTiles, (int index) =>  TicTacToeTiles(index, "", Colors.white));

    return _TicTacToeState();
  }

  List<List<int>> generatePositionWinList() {

    print("TileNumberList : ");
    List<int> tileNumberList = List<int>.generate(numberTiles, (index) => index);
    tileNumberList.forEach((element) { print(element);});

    var positionWinsHorizontal = partition(tileNumberList, crossAxisCount);

    print("Position win horizontal : ");
    positionWinsHorizontal.forEach((element) { print(element);});

    var positionWinsVertical = [];

    var list = [];
    print("TRAITEMENT");
    for(int i=0; i<crossAxisCount; i++){
      positionWinsHorizontal.forEach((element) {
        //print(element);
        print("Add : ${element[i]}");
        list.add(element[i]);
      });

      print("List to add : " + list.toString());
      positionWinsVertical.add(list);
      print("Update :" + positionWinsVertical.toString());
      list.clear();
    }

    print("Position win vertical : ${positionWinsVertical}");

    print("CROSS AXIS : ${crossAxisCount}");

    List<List<int>> positionWins = [
      //Horizontal
      [0,1,2],
      [3,4,5],
      [6,7,8],

      //Vertical
      [0,3,6],
      [1,4,7],
      [2,5,8],

      //Diagonal
      [0,4,8],
      [2,4,6]
    ];
    return positionWins;
  }

}

class _TicTacToeState extends State<TicTacToe>{

  int playerNumberTour = 0;
  Color playerColorTour = Colors.blue;
  String textCaseSelected = "";

  List<TicTacToeTiles> tilesList;

  @override
  void initState() {
    super.initState();
    tilesList = widget.tilesList;
    //playerColorTour = widget.playerList[playerNumberTour].playerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tic tac toe"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${widget.playerList[0].playerName}", style: TextStyle(fontSize: 25.0, )),
              Text(" VS ", style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, )),
              Text("${widget.playerList[1].playerName}", style: TextStyle(fontSize: 25.0)),
              Container(height: 50.0,)
            ],
          ),
          Expanded(
            child: GridView.builder(
              itemCount: tilesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: widget.crossAxisCount),
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        if(tilesList[i].text == ""){
                          tilesList[i].text =  (playerNumberTour == 0) ? "O" : "X";
                          //tilesList[i].color =  widget.playerList[playerNumberTour].playerColor;

                          checkVictory(playerNumberTour);
                          changePlayer();
                        }
                        //TODO snackbar error : choose another tile

                      });
                    },
                    child: Card(
                      color: tilesList[i].color,
                      elevation: 10.0,
                      child: Container(
                        child: Text(tilesList[i].text, style: TextStyle(color: Colors.white),),
                      ),
                    )
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

  int changePlayer(){
    if(playerNumberTour == 0){
      playerNumberTour = 1;
    } else {
      playerNumberTour =0;
    }
  }

  void checkVictory(int playerNumberTour) {
    List<List<int>> positionWins = [];

    List<int> caseListPlayer1 = [];
    List<int> caseListPlayer2 = [];
    tilesList.forEach((element) {
      if(element.text == "O"){
        caseListPlayer1.add(element.id);
      } else if (element.text == "X"){
        caseListPlayer2.add(element.id);
      }
    });

    print("Case player 1 list :");
    caseListPlayer1.forEach((element) {
      print("$element");
    });
    print("Case player 2 list :");
    caseListPlayer2.forEach((element) {
      print("$element");
    });


    positionWins.forEach((positionList) {
     //print("Win list to check ${positionList[0]}, ${positionList[1]}, ${positionList[2]}");
      int indexWinner;
      print("PLAYER NUMBER TOUR : $playerNumberTour");
      if(playerNumberTour == 0){
        if(caseListPlayer1.contains(positionList[0]) && caseListPlayer1.contains(positionList[1]) && caseListPlayer1.contains(positionList[2])){
          indexWinner = playerNumberTour;
          print("CONTAIN 1 : $playerNumberTour");
          gameEnd(indexWinner);
        }
      }else {
        if(caseListPlayer2.contains(positionList[0]) && caseListPlayer2.contains(positionList[1]) && caseListPlayer2.contains(positionList[2])){
          indexWinner = playerNumberTour;
          print("CONTAIN 2 : $playerNumberTour");

          gameEnd(indexWinner);
        }
      }
    });

    checkAllTilesAreSelected();
  }

  void checkAllTilesAreSelected(){
    int count = 0;
    tilesList.forEach((element) {
      if(element.text != ""){
        count ++;
      }
    });
    if(count == 9){
      gameEnd(null);
    }
  }

  void resetGame(){
    setState(() {
      tilesList.forEach((element) {
        element.text="";
        element.color= Colors.white;
      });
    });
  }

  Future<Null> gameEnd(int indexWinner){
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Jeu terminé"),
            content: Text((indexWinner == null) ? "Aucun gagnant" : "Le gagnant est ${widget.playerList[indexWinner].playerName}"),
            actions: <Widget>[
              FlatButton(
                child: Text("Quitter"),
                color: Colors.red,
                onPressed: (){
                  Navigator.pop(buildContext);
                },
              ),
              FlatButton(
                child: Text("Recommencer"),
                color: Colors.blue,
                onPressed: (){
                  resetGame();
                  Navigator.pop(buildContext);
                },
              )
            ],
          );
        }
    );

  }

}