

class Word {
  int id;
  String word;
  int difficulty;

  Word({
    this.id,
    this.word,
    this.difficulty,
  });


  @override
  String toString() {
    return 'Word{id: $id, word: $word, difficulty: $difficulty}';
  }

  factory Word.fromMap(Map<String, dynamic> data) => new Word(
    id: data["id"],
    word: data["word"],
    difficulty: data["difficulty"],
  );

  /// Retrieve from sqfLite
  void fromMap(Map<String, dynamic> map){
    this.id = map["id"];
    this.word = map["word"];

  }

  /// To send data to database
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "word" : this.word,
      "difficulty": difficulty,
    };
    if(id != null){
      map['id'] = this.id;
    }
    return map;
  }
}