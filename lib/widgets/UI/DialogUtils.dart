import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils{

  static Future<dynamic> infoDialog(BuildContext context, String title, String description){
    return AwesomeDialog(context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        tittle: title,
        desc: description,
        btnCancelOnPress: () {},
        btnOkOnPress: () {})
        .show();
  }

}