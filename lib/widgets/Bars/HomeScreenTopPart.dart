import 'package:flutter/material.dart';
import 'package:gamesapp/models/enums/EGamesType.dart';
import 'package:gamesapp/models/games.dart';
import 'package:gamesapp/widgets/UI/CustomShapeClipper.dart';

Color firstColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);

class HomeScreenTopPart extends StatefulWidget{
  @override
  _HomeScreenTopPart createState() => _HomeScreenTopPart();
}

class _HomeScreenTopPart extends State<HomeScreenTopPart>{

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      firstColor,
                      secondColor
                    ]
                )
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(icon : Icon(Icons.home), color: Colors.white,),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Text("My Games App", style: TextStyle(fontSize : 28.0, color: Colors.white),textAlign: TextAlign.center,),
                SizedBox(height: 50.0,),

              ],
            ),
          ),
        ),
      ],
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