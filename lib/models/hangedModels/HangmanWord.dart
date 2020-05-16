import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

class HangmanWord {
  static List<String> _words = [];

  static Future readWords() async {
    String fileText = await rootBundle.loadString('res/hangman_words');
    _words = fileText.split('\n');
    print(_words);
  }

  static String getWord(){
    Random _random = Random();
    if(_words.isNotEmpty){
      return _words[_random.nextInt(_words.length)];
    }
    return "NULL";
  }

}