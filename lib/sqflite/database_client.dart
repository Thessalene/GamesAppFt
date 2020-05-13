import 'package:gamesapp/models/hangedModels/word.dart';
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

  ///Insert
  Future<int> insertWord(Word word) async {
    //Check if database exists
    Database myDatabase = await database;
    //Nous renvoie un int que l'on assigne à item.id
    word.id = await myDatabase.insert(HANGED_WORD_TABLE, word.toMap());
    return word.id;
  }

  ///Read
  Future<List<Word>> allWords() async {
    Database myDatabase = await database;
    List<Word> wordList = [];
    //Nous renvoie un int que l'on assigne à word.id
    List<Map> words = await myDatabase.query(HANGED_WORD_TABLE);
    words.forEach((map) {
      Word word = Word();
      word.fromMap(map);
      wordList.add(word);
    });
    return wordList;
  }

  Future<Word> getWordFromDifficulty(int difficulty) async {
    Database myDatabase = await database;

    List<Map> results = await myDatabase.query(HANGED_WORD_TABLE,
        where: 'difficulty = ?',
        whereArgs: [difficulty]);

    if (results.length > 0) {
      return new Word.fromMap(results.first);
    }
    return null;
  }

}