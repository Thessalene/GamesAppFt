import 'package:flutter/material.dart';

enum EGamesType { TIC_TAC_TOE, BATTLESHIP, HANGED }

class EgamesTypeHelper {

  String getNameFromType(EGamesType type) {
    String result;
    switch (type) {
      case EGamesType.TIC_TAC_TOE:
        result = "Tic Tac Toe";
        break;
      case EGamesType.BATTLESHIP:
        result = "Battleship";
        break;
      case EGamesType.HANGED:
        return "Hanged";
        break;
    }
    return result;
  }
}
