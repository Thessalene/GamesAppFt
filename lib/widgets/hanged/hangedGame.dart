import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gamesapp/models/Letter.dart';
import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:gamesapp/models/player.dart';
import 'package:gamesapp/sqflite/database_client.dart';
import 'package:gamesapp/widgets/UI/DialogUtils.dart';
import 'package:quiver/strings.dart';
import 'package:easy_dialog/easy_dialog.dart';

class HangedGame extends StatefulWidget{

  @override
  _HangedGameState createState() {
    return _HangedGameState();}
}

class _HangedGameState extends State<HangedGame>{
  TextEditingController _pseudoController = new TextEditingController();

  int nbLives = 1;
  bool finishedGame = false;
  int errorNb = 0;
  List<Letter> letterList;
  List<Letter> wordToFindArray = [];
  String wordToFind;
  int score = 0;

  void initGame(){
    finishedGame = false;
    errorNb = 0;

    wordToFind = HangmanWord.getWord().trim();
    print("The word is : $wordToFind");

    wordToFind.split("").forEach((element) {
      Letter letterToAdd = Letter(element.toUpperCase(), false);
      if(element == "-"){
        letterToAdd.selected = true;
      }
      wordToFindArray.add(letterToAdd);
    });
    print(wordToFindArray);

    //Init alphabet list letter
    letterList = Letter.generateLetterList();
  }

  void nextGame(){
    setState(() {
      finishedGame = false;
      errorNb = 0;

      wordToFind = HangmanWord.getWord().trim();
      print("The next word is : $wordToFind");

      wordToFindArray =[];
      wordToFind.split("").forEach((element) {
        Letter letterToAdd = Letter(element.toUpperCase(), false);
        if(element == "-"){
          letterToAdd.selected = true;
        }
        wordToFindArray.add(letterToAdd);
      });
      print(wordToFindArray);

      //Init alphabet list letter
      letterList = Letter.generateLetterList();
    });
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFF8F3985),
      body: SafeArea(

        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //Text("$nbLives"),
                    Stack(
                      children: [
                        Icon(Icons.favorite_border,color: Colors.white, size: 33.0,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.0, 8.0, 0.0, 0.0),
                          child: Text("$nbLives", style: TextStyle(color : Colors.white, fontWeight: FontWeight.bold,),),
                        ),
                      ],
                    ),
                    Text("Score : $score", style: TextStyle(color: Colors.white),),
                    Text("Errors : $errorNb", style: TextStyle(color: Colors.white),),
                    Icon(Icons.lightbulb_outline, color: Colors.white,),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Image.asset(
                      'assets/handgman.png',
                      scale: 0.4,
                      gaplessPlayback: true,
                      height: 200.0,
                      width: 200.0,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height : MediaQuery.of(context).size.height/10,
                child: (wordToFindArray != null || wordToFindArray.isNotEmpty)?
              Center(
                child: ListView.builder(
                    itemCount: wordToFindArray.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i){
                      //print("list : ${wordToFindArray[i]}");
                      return Center(
                        child: Container(
                              child : Text(
                                (wordToFindArray[i].selected == true) ? " ${wordToFindArray[i].letter} " : "  _  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),

                              ),
                          ),
                      );
                    }),
              ):
              Text("WordList vide ou null")
                ),
              Expanded(
                flex: 3,
                child: Container(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                      itemCount: letterList.length,
                      itemBuilder: (context, i){
                        Letter letter = letterList[i];
                        return InkWell(
                          child: Card(
                            color: (letter.selected)? Colors.purpleAccent : Colors.white,
                            elevation: 5.0,
                            child: Container(
                              child: Text(
                                letter.letter,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: (letter.selected)? Colors.white : Colors.black
                                ),
                              ),
                            ),
                          ),
                          onTap: (){
                            if(!letter.selected){
                              setState(() {
                                print("On tap on ${letter.letter}");
                                letterList[i].selected = true;
                                checkLetter(letter.letter);
                                checkEndGame();
                              });
                            }
                          },
                        );
                      }
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void checkLetter(String letter){
    bool foundALetter = false;
    wordToFindArray.forEach((element) {
      if(equalsIgnoreCase(element.letter, letter)){
        print("CONTIENT");
        element.selected = true;
        foundALetter = true;
      }
    });
    if(!foundALetter){
      errorNb++;
    }

  }

  void checkEndGame() {
    if(errorNb == 10){
      //Finish and decrease lives
      nbLives--;
      endGame(false);
      return;
    }
    var listOfLetterRemained = wordToFindArray.where((letter) => letter.selected==false).toList();
    //If there is no letter to find
    if(listOfLetterRemained.isEmpty){
      print("C'est gagné !");
      score = score+ wordToFindArray.length * 10;
      endGame(true);
    } else {
      print("Essaie encore !");
    }
  }

  void endGame(bool isWin){
    if(isWin){
      infoDialog(context,"Bien joué !","Faites péter les scores !", DialogType.SUCCES);
    } else {
      infoDialog(context,"Echec !","Il vous reste $nbLives vies.", DialogType.ERROR);
    }
  }

  Future<dynamic> infoDialog(BuildContext context, String title, String description, DialogType type){
    return AwesomeDialog(context: context,
        dialogType: type,
        animType: AnimType.BOTTOMSLIDE,
        tittle: title,
        desc: description,
        btnCancel: null,
        btnOkText: (nbLives > 0) ?"Suivant" : "Terminé",
        btnOkOnPress: () {
          print("Click on ok");
          if(nbLives > 0){
            nextGame();
          } else {
            //Ask pseudo to save score
            pseudoDialog();
          }
        })
        .show();
  }

  Future<dynamic> pseudoDialog(){
    return EasyDialog(
      descriptionPadding: EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height/2,
      title: Text("Votre score : $score.", style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.bold, fontSize: 20.0),),
    contentList: [
        Container(
          margin: EdgeInsets.all(10.0),
          child: Theme(
            data :Theme.of(context).copyWith(accentColor: Colors.purple, primaryColor: Colors.purple),
            child: TextField(
              controller: _pseudoController,
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Colors.purple,
              maxLength: 12,
              decoration: InputDecoration(
                focusColor: Colors.purple,
                icon: Icon(Icons.person_add, color: Colors.purple,),
                labelText: "Entrez votre pseudo",
                labelStyle: TextStyle(
                  color: Colors.purple,
                  decorationColor: Colors.purple,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new FlatButton(
              padding: const EdgeInsets.only(top: 8.0),
              highlightColor: Colors.purple[400],
              child: new Text(
                "Valider",
                style: TextStyle(color: Colors.purple),
                textScaleFactor: 1.2,
              ),
              onPressed: () {
                print("Go to score page");
                Player playerToAdd = Player();
                playerToAdd.playerName = _pseudoController.text;
                playerToAdd.score = score;
                playerToAdd.gameId = 1;
                DatabaseClient().addItemToDatabase(playerToAdd).then(
                        (value) => recupererDonnees());
              },
            ),
          ],
        )
      ],
      closeButton: false,
    ).show(context);
  }

  void recupererDonnees(){
    print("Récupérer les données : ");
    DatabaseClient().allItems().then((players){
      setState(() {
        print(players.toString());
      });
    });
  }

}