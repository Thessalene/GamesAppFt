import 'dart:math';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gamesapp/models/Letter.dart';
import 'package:gamesapp/models/enums/EDifficultyType.dart';
import 'package:gamesapp/models/hangedModels/word.dart';
import 'package:gamesapp/models/player.dart';
import 'package:gamesapp/sqflite/database_client.dart';
import 'package:list_french_words/list_french_words.dart';

class Hanged extends StatefulWidget{
  final EDifficultyType selectedDifficulty;
  final List<Player> playerList;

  Hanged(this.selectedDifficulty, this.playerList);

  @override
  _HangedState createState() {
    return _HangedState();}
}

class _HangedState extends State<Hanged>{

  int nbMaxError = 7;
  List<Letter> letterList;
  int errorNb = 0;

  List<Letter> wordToFindLetterList= [];
  String wordToFind;
  int wordToFindIndex = 0;
  List<Word> wordList;

  String score;

  @override
  void initState() {
    super.initState();
    //Generate a random list of words of 10 words
    print("INIT STATE");
    test();
    print("INIT STATE 2");
    score = (wordList != null) ? "${widget.playerList[0].score}/${wordList.length}" : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hanged"),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            textStyle('${widget.playerList[0].playerName} : $score' , fontSize: 20.0),
            Padding(padding: EdgeInsets.all(10.0),),
            Image.asset("assets/hanging-rope.png", scale: 8.0,),
            SizedBox(
              height: 30.0,
             child: (wordList != null || wordList.isNotEmpty)?
             ListView.builder(
                 itemCount: wordToFind.length,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, i){
                   return Container(
                     width: MediaQuery.of(context).size.width/wordToFindLetterList.length,
                     child: Text((wordToFindLetterList[i].selected == true) ? "${wordToFindLetterList[i].letter}" : "_", textAlign: TextAlign.center,),
                   );
                 }):
                 Text("WordList vide ou null")
           ),
            Padding(padding: EdgeInsets.all(5.0),),
            Text("Nombre d'erreur : $errorNb"),
            Padding(padding: EdgeInsets.all(5.0),),
            Expanded(
             child: GridView.builder(
                 itemCount: letterList.length,
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                 itemBuilder: (context, i){
                   return InkWell(
                     child: Card(
                       child: Container(
                         color: (letterList[i].selected)? Colors.red : Colors.white,
                         child: Text(letterList[i].letter),
                       ),
                     ),
                     onTap: (){
                       setState(() {
                         letterList[i].selected=true;
                         print(letterList[i].toString());
                         if(containsLetter(letterList[i])){
                           print("CONTIENT");
                           wordToFindLetterList.forEach((element) {
                             if(element.letter == letterList[i].letter){
                               element.selected= true;
                             }
                             print(element.toString());
                           });
                         } else {
                           errorNb ++;
                         }
                         endGameDialog();
                       });
                     },
                   );
                 }),
           )

          ],
        ),
    );
  }

  void test() async{
    var liste = await DatabaseClient().getWordListFromDifficulty(1, 5);
    print("VALUE LISTE : $liste");

    setState(() {
      wordList = liste;
      print("VALUE WORDLIST : $wordList");
      print("Wordlist : ${wordList}");
      wordToFind = wordList[wordToFindIndex].word;
      wordToFind.split("").forEach((element) {
        Letter letter = Letter(element, false);
        if(element == "-") {
          letter.selected = true;
        }
        wordToFindLetterList.add(letter);
      });
      print("Word to find :$wordToFind");
      letterList = Letter.generateLetterList();
    });
  }

  Text textStyle(String data, {color : Colors.orange, fontSize : 15.0}){
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.bold
      ),
    );

  }

  bool isWin(){
    int count = 0;
    wordToFindLetterList.forEach((element) {
      if(element.selected = false){
         count ++;
      }
    });
    return count != 0;
  }

  Future<Null> endGameDialog(){
    String failMessage = "Vous n'avez pas trouvé le mot : $wordToFind";
    String successMessage = "Vous avez trouvé le mot : $wordToFind";
    if(errorNb == nbMaxError || isWin()){
      return showDialog(
          context: context,
        builder: (BuildContext buildContext){
            return AlertDialog(
              title: Text("Jeu terminé"),
              content: Text((errorNb == nbMaxError)? failMessage : successMessage),
              actions: <Widget>[

                (wordToFindIndex == wordList.length-1) ?
                FlatButton(
                  child: Text("Terminer"),
                  onPressed: (){

                  },
                ) :
                FlatButton(
                child: Text("Suivant"),
                  onPressed: (){
                    setState(() {
                      wordToFindIndex ++;
                      wordToFind = wordList[wordToFindIndex].word;
                      print("NEW WORDFIND : $wordToFind");
                      wordToFindLetterList = [];
                      wordToFind.split("").forEach((element) {
                        Letter letter = Letter(element, false);
                        if(element == "-") {
                          letter.selected = true;
                        }
                        wordToFindLetterList.add(letter);
                      });
                      print("ARRAY NEW WORDTOFIND $wordToFindLetterList");
                    });
                    //Navigator.pop(buildContext);
                  },
                ),
              ],
            );
        }
      );
    } else {
      return null;
    }
  }

  bool containsLetter(Letter letterToFind){
    for(Letter letter in wordToFindLetterList){
      if(letter == letterToFind){
        return true;
      }
    }
    return false;
  }

  void changeLetterWordStatus(String letterFound){

  }

}