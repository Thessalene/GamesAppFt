import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EGamesType.dart';

class Game{
  EGameType _gameType;
  String _name;
  String _image;

  Game(this._gameType, this._name, this._image);

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  EGameType get gameType => _gameType;

  set gameType(EGameType value) {
    _gameType = value;
  }


}