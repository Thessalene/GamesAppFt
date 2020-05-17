import 'package:flutter/material.dart';

class GameConfiguration extends StatefulWidget {

  @override
  _GameConfiguration createState() {
    return _GameConfiguration();
  }

}

class _GameConfiguration extends State<GameConfiguration> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuration"),),
      backgroundColor: Colors.blue,
      resizeToAvoidBottomPadding: true,
    );
  }

}