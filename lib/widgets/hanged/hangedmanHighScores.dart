import 'package:flutter/material.dart';
import 'package:gamesapp/models/score.dart';
import 'package:gamesapp/sqflite/database_client.dart';
import 'package:gamesapp/widgets/hanged/hangedHomePage.dart';

class HangedmanHighScores extends StatefulWidget {
  @override
  _HangedmanHighScores createState() => _HangedmanHighScores();
}

class _HangedmanHighScores extends State<HangedmanHighScores> {
  List<Score> scoreList = [];

  @override
  void initState() {
    super.initState();
    recupererDonnees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        resizeToAvoidBottomPadding: true,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon : Icon(Icons.home, color: Colors.white,),
                    onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HangedHomePage()
                        ));
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "High Scores",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: scoreList.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Icon(
                          Icons.stars,
                          color: getColor(i),
                        ),
                        title: Text(scoreList[i].playerName, style: TextStyle(color : Colors.white),),
                        trailing: Text(scoreList[i].score.toString(), style: TextStyle(color : Colors.white),),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  Color getColor(int i){
    switch(i){
      case 0 :
        return Colors.yellowAccent;
        break;
      case 1 :
        return Colors.brown;
        break;
      case 2 :
        return Colors.grey;
        break;
      default :
        return Colors.white;
        break;
    }
  }

  void recupererDonnees() {
    print("Récupérer les données : ");
    DatabaseClient().allItems().then((players) {
      setState(() {
        scoreList = players;
        print(players.toString());
      });
    });
  }
}
