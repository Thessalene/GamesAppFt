import 'package:flutter/material.dart';

class Games{
  String _name;
  String _image;

  Games(this._name, this._image);

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}