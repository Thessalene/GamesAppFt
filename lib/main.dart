import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:gamesapp/models/hangedModels/word.dart';
import 'package:gamesapp/sqflite/database_client.dart';
import 'dart:async';
import 'package:list_french_words/list_french_words.dart';
import 'package:gamesapp/widgets/home.dart';
import 'package:quiver/strings.dart';

ThemeData appTheme = ThemeData(
    primaryColor: Color(0xFFF37918),
    fontFamily: 'Oxygen'
);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {return _MyAppState();}
}
/// SplashScreen Page
class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 1),
        (){
          List<Word> wordList = [];

          //If database is empty
          DatabaseClient().allWords().then((value){
            if(value.length == 0){
              print("Wordlist to add to db :");
              for(int i=0; i<30; i++) {
                final _random = new Random();
                var element = list_french_words[_random.nextInt(
                    list_french_words.length)];
                if (element.length < 12 && element.length > 6) {
                  print(element);
                  wordList.add(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty : 1));
                  DatabaseClient().insertWord(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty: 1));
                } else if (element.length < 6 && element.length > 3){
                  print(element);
                  wordList.add(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty : 0));
                  DatabaseClient().insertWord(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty: 0));
                } else {
                  print(element);
                  wordList.add(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty : 2));
                  DatabaseClient().insertWord(Word(id : null, word : removeDiacritics(element.toUpperCase()), difficulty: 2));
                }
              }
            }
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext){
              return HomeScreen();
            }));
          });
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 400,
        ),
      ),
    );
  }

}
