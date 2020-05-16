import 'package:flutter/material.dart';


class ActionButton extends StatelessWidget {

  ActionButton({this.buttonTitle, this.onPress, this.color, this.highlightColor});

  final Function onPress;
  final String buttonTitle;
  var highlightColor;
  var color;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 3.0,
      color: color,
      highlightColor: highlightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: onPress,
      child: Text(
        buttonTitle,
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }
}