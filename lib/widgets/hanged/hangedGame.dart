import 'package:flutter/material.dart';
import 'package:gamesapp/models/Letter.dart';
import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:quiver/strings.dart';

class HangedGame extends StatefulWidget{

  @override
  _HangedGameState createState() {
    return _HangedGameState();}
}

class _HangedGameState extends State<HangedGame>{

  int nbLives = 5;
  bool finishedGame = false;
  int errorNb = 0;
  List<Letter> letterList;
  List<Letter> wordToFindArray = [];
  String wordToFind;

  void initGame(){
    finishedGame = false;
    errorNb = 0;

    wordToFind = HangmanWord.getWord().trim();
    print("The word is : $wordToFind");

    wordToFind.split("").forEach((element) {
      wordToFindArray.add(Letter(element.toUpperCase(), false));
    });
    print(wordToFindArray);
    print(wordToFindArray.length);

    //Init alphabet list letter
    letterList = Letter.generateLetterList();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text("Score : 0/5", style: TextStyle(color: Colors.white),),
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
                height : MediaQuery.of(context).size.height/12,
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
                            setState(() {
                              print("On tap on ${letter.letter}");
                              letterList[i].selected = true;
                              checkLetter(letter.letter);
                              checkEndGame();
                            });
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
      //endGame(false);
      return;
    }
    var listOfLetterRemained = wordToFindArray.where((letter) => letter.selected==false).toList();
    //If there is no letter to find
    if(listOfLetterRemained.isEmpty){
      print("C'est gagné !");
      //ednGame(true);
    } else {
      print("Essaie encore !");
    }
  }

  void endGame(bool isWin){
    if(isWin){

    } else {

    }
  }


}