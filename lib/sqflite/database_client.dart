import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:gamesapp/models/score.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class DatabaseClient {

  static const SCORE_TABLE = "score";
  static const GAME_TABLE = "game";

  Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    } else {
      //Create the database
      _database = await createDatabase();
      return _database;
    }
  }

  ///Create the database
  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'gameDatabase.db');

    var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  ///Create the database table(s)
  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE $SCORE_TABLE ("
        "id INTEGER PRIMARY KEY,"
        "pseudo TEXT,"
        "score INTEGER,"
        "gameId INTEGER"
        ")");

    await database.execute("CREATE TABLE $GAME_TABLE ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "game TEXT"
        ")");

    // Insert some records in a transaction
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $GAME_TABLE(game) VALUES("hangedman")');
      print('inserted1: $id1');
      int id2 = await txn.rawInsert(
          'INSERT INTO $GAME_TABLE(game) VALUES("tictactoe")');
      print('inserted2: $id2');
      int id3 = await txn.rawInsert(
          'INSERT INTO $GAME_TABLE(game) VALUES("battleship")');
      print('inserted3: $id3');
    });
  }

/* Data writing */

  Future<Score> addItemToDatabase(Score score) async{
    //Check if database exists
    Database myDatabase = await database;
    //Nous renvoie un int que l'on assigne à score.playerId
    score.playerId = await myDatabase.insert("$SCORE_TABLE", score.toMap());
    return score;
  }

/* Data reading */
  Future<List<Score>> allItems() async{
    //Check if database exists
    Database myDatabase = await database;
    List<Score> scores = [];

    List<Map<String, dynamic>> result = await myDatabase.rawQuery("SELECT * FROM $SCORE_TABLE ORDER BY score DESC");

    result.forEach((map) {
      Score score = Score();
      score.fromMap(map);
      scores.add(score);
    });
    return scores;
  }







}