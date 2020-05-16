import 'package:gamesapp/models/hangedModels/HangmanWord.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class DatabaseClient {

  static const HANGED_WORD_TABLE = "handgedWord";

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
    await database.execute("CREATE TABLE $HANGED_WORD_TABLE ("
        "id INTEGER PRIMARY KEY,"
        "word TEXT,"
        "difficulty INTEGER"
        ")");
    //Difficulty : 0,1 or 2
  }


}