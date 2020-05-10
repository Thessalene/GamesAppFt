import 'package:flutter/material.dart';
import 'package:gamesapp/models/player.dart';
import 'package:gamesapp/models/tictactoe_tiles.dart';
import 'package:gamesapp/widgets/home.dart';


class TicTacToe extends StatefulWidget{
  final List<Player> playerList;

  TicTacToe(this.playerList);

  @override
  State<StatefulWidget> createState() {
    return _TicTacToeState();
  }

}

class _TicTacToeState extends State<TicTacToe>{

  int playerNumberTour = 0;
  Color playerColorTour = Colors.blue;
  String textCaseSelected = "";

  List<TicTacToeTiles> tilesList = [
    TicTacToeTiles(0, "", Colors.white),
    TicTacToeTiles(1, "", Colors.white),
    TicTacToeTiles(2, "", Colors.white),
    TicTacToeTiles(3, "", Colors.white),
    TicTacToeTiles(4, "", Colors.white),
    TicTacToeTiles(5, "", Colors.white),
    TicTacToeTiles(6, "", Colors.white),
    TicTacToeTiles(7, "", Colors.white),
    TicTacToeTiles(8, "", Colors.white),
  ];

  @override
  void initState() {
    super.initState();
    playerColorTour = widget.playerList[playerNumberTour].playerColor;
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
              Text("${widget.playerList[0].playerName}", style: TextStyle(fontSize: 25.0, color: widget.playerList[0].playerColor),),
              Text(" VS ", style: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.grey[800]),),
              Text("${widget.playerList[1].playerName}", style: TextStyle(fontSize: 25.0, color: widget.playerList[1].playerColor),),
              Container(height: 50.0,)
            ],
          ),
          Expanded(
            child: GridView.builder(
              itemCount: tilesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, i){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        if(tilesList[i].text == ""){
                          tilesList[i].text =  (playerNumberTour == 0) ? "O" : "X";
                          tilesList[i].color =  widget.playerList[playerNumberTour].playerColor;

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