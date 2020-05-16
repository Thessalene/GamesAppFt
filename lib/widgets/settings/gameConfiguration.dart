import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EDifficultyType.dart';
import 'package:gamesapp/models/enums/EGamesType.dart';
import 'package:gamesapp/models/player.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'file:///D:/Documents/AndroidStudioProjects/games_app/lib/widgets/hanged/hangedGame.dart';
import 'file:///D:/Documents/AndroidStudioProjects/games_app/lib/widgets/TicTacToe/tictactoe.dart';

class GameConfiguration extends StatefulWidget {

  final EGameType gameType;
  int nbPlayer=0;

  GameConfiguration(this.gameType);

  @override
  _GameConfiguration createState() {
    nbPlayer = EGameTypeHelper().getPlayerNbFromType(gameType);
    return _GameConfiguration();
  }

}

class _GameConfiguration extends State<GameConfiguration> {

  List<Player> playerList = [];
  int playerNumber;
  EDifficultyType selectedDifficulty;

  List<EDifficultyType> difficultyList = EDifficultyType.values;

  @override
  void initState() {
    playerList = List<Player>.generate(widget.nbPlayer, (index) => Player(index, "", Colors.blue, 0),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuration"),),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            textStyle(EGameTypeHelper().getNameFromType(widget.gameType), 35.0, Colors.blue),
            Padding(padding: EdgeInsets.all(10.0),),
            textStyle("Veuillez configurer le jeu. Vous pouvez changer la couleur de votre joueur en cliquant son icone", 15.0, Colors.grey[700]),
            selectDifficulty(),
            Padding(padding: EdgeInsets.all(10.0),),
            Expanded(
              child: ListView.builder(
                  itemCount: EGameTypeHelper().getPlayerNbFromType(widget.gameType),
                  itemBuilder: (context, i){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.account_circle), color: playerList[i].playerColor, iconSize: 45.0,
                          onPressed: (){
                            MaterialColorPicker(
                                onColorChange: (Color color) {
                                  // Handle color changes
                                },
                                selectedColor: Colors.blue
                            );
                          },
                        ),
                        Flexible(
                          child: playerRow(i),
                        )
                      ],
                    );
                  }),
            ),
            RaisedButton(
              elevation: 15.0,
              color: Colors.blue,
              child: Text("Commencer"),
              onPressed: (){
                bool valid = false;
                playerList.forEach((player) {
                  if(player.playerName.isEmpty){
                    valid = false;
                  } else {
                    valid = true;
                  }
                });
                if(valid){
                  switch(widget.gameType) {
                    case EGameType.TIC_TAC_TOE:
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext buildContext) {
                            return TicTacToe(selectedDifficulty, playerList);
                          }));
                      break;
                    case EGameType.BATTLESHIP:
                      print("BATTLESHIP");
                      break;
                    case EGameType.HANGED:
                      Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext buildContext) {
                            return HangedGame();
                          }));
                      break;
                  //TODO call widget in function of Game
                  }
                } else {
                  print("Erreur");

                }
              },
            )
          ],
        ),
      ),
    );
  }

  TextFormField playerRow(int index){
    return new TextFormField(
      key: Key("player$index"),
      decoration: new InputDecoration(
        labelText: "Player ${index+1}",
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(
          ),
        ),
        //fillColor: Colors.green
      ),
      onChanged: (String str){
        setState(() {
          print("VAL PLAYER $index : $str");
          playerList[index].playerName=str;
        });
      },

      validator: (val) {
        if (val.length == 0) {
          return "Player name cannot be empty";
        } else {

          return null;
        }
      },
      keyboardType: TextInputType.text,
      style: new TextStyle(
        fontFamily: "Poppins",
      ),
    );
  }

  Padding padding() {
    return Padding(
        padding: EdgeInsets.only(bottom : 40.0, right: 10.0)
    );
  }

  Text textStyle(String text, fontSize, Color color) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize: fontSize
      ),
    );
  }

  DropdownButton selectDifficulty(){
    return DropdownButton<EDifficultyType>(
      hint:  Text("Selectionner la difficulté"),
      value: selectedDifficulty,
      onChanged: (EDifficultyType value) {
        setState(() {
          selectedDifficulty = value;
        });
      },
      items: difficultyList.map((EDifficultyType difficulty) {
        return  DropdownMenuItem<EDifficultyType>(
          value: difficulty,
          child: Row(
            children: <Widget>[
              SizedBox(width: 10,),
              Text(
                EDifficultyTypeHelper().getStringFromDifficultyType(difficulty),
                style:  TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}