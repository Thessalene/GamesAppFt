import 'package:flutter/material.dart';
import 'package:gamesapp/components/ActionButton.dart';
import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:gamesapp/widgets/hanged/hangedmanHighScores.dart';
import 'hangedGame.dart';

class HangedHomePage extends StatefulWidget{
  final HangmanWord hangmanWord = HangmanWord();

  @override
  _HangedHomePage createState() => _HangedHomePage();
}

class _HangedHomePage extends State<HangedHomePage>{


  @override
  void initState() {
    super.initState();
    HangmanWord.readWords();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //widget.hangmanWords.readWords();
    return Scaffold(
      backgroundColor: Color(0xFF8F3985),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
                  child: Text(
                    'HANGMAN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3.0),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/handgman.png',
                    height: height * 0.5,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.049,
              ),
              Center(
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
//                    width: 155,
                        height: 64,
                        child: ActionButton(
                          color: Color(0xFFA675A1),
                          buttonTitle : 'Start',
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HangedGame(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Container(
//                    width: 155,
                        height: 64,
                        child: ActionButton(
                          color: Color(0xFFA675A1),
                          buttonTitle: 'High Scores',
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HangedmanHighScores(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
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

