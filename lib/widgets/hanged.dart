import 'dart:math';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gamesapp/models/Letter.dart';
import 'package:gamesapp/models/enums/EDifficultyType.dart';
import 'package:gamesapp/models/player.dart';
import 'package:list_french_words/list_french_words.dart';

class Hanged extends StatefulWidget{
  final EDifficultyType selectedDifficulty;
  final List<Player> playerList;

  Hanged(this.selectedDifficulty, this.playerList);

  @override
  _HangedState createState() {return _HangedState();}
}

class _HangedState extends State<Hanged>{

  int nbMaxError = 7;
  List<Letter> letterList;
  int errorNb = 0;

  List<String> wordList = [];

  List<Letter> wordToFindArray = [];
  List<String> wordToFindStrArray = [];
  String wordToFind;
  int wordToFindIndex = 0;

  @override
  void initState() {
    super.initState();
    //Generate a random list of words of 10 words
    print("WORDLIST : ");
    for(int i=0; i<10; i++){
      final _random = new Random();
      var element = list_french_words[_random.nextInt(list_french_words.length)];
      if(element.length < 12 && element.length > 6){
        print(element);
        wordList.add(element.toUpperCase());
      }
    }

    wordToFind = removeDiacritics(wordList[wordToFindIndex]);
    print("Word to find :$wordToFind");

      wordToFindArray = Letter.convertStringListIntoLetterList(wordToFind.split(""));
      letterList = Letter.generateLetterList();
      print("WORD TO FIND ARRAY :");
      wordToFindArray.forEach((element) {
        print(element.letter);
        wordToFindStrArray.add(element.letter);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hanged"),),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            textStyle('${widget.playerList[0].playerName} : ${widget.playerList[0].score}/${wordList.length}', fontSize: 20.0),
            Padding(padding: EdgeInsets.all(10.0),),
            Image.asset("assets/hanging-rope.png", scale: 8.0,),
            SizedBox(
              height: 30.0,
             child: ListView.builder(
                 itemCount: wordToFindArray.length,
                 scrollDirection: Axis.horizontal,
                 itemBuilder: (context, i){
                   return Container(
                     width: MediaQuery.of(context).size.width/wordToFindArray.length,
                     child: Text((wordToFindArray[i].selected == true) ? "${wordToFindArray[i].letter}" : "_", textAlign: TextAlign.center,),
                   );
                 }),
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
                         if(wordToFindStrArray.contains(letterList[i].letter)){
                           print("CONTIENT");
                           wordToFindArray.forEach((element) {
                             if(element.letter == letterList[i].letter){
                               element.selected= true;
                             }
                             print(element.toString());
                           });
                         } else {
                           errorNb ++;
                         }
                       });
                     },
                   );
                 }),
           )

          ],
        ),
    );
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
    wordToFindArray.forEach((element) {
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
                    print("WORDFIND BEFORE : $wordToFind");
                    wordToFindIndex ++;
                    print("WORDFIND AFTER : $wordToFind");
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

  void changeLetterWordStatus(String letterFound){

  }

}