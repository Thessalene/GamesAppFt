

import 'package:flutter/material.dart';

class TicTacToeTiles{
  int _id;
  String _text;
  Color _color;

  TicTacToeTiles(this._id, this._text, this._color);

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}