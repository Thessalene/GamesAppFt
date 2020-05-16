
class Score{
  int playerId;
  String playerName;
  int score = 0;
  int gameId;

  Score();

  @override
  String toString() {
    return 'Score{playerId: $playerId, playerName: $playerName, score: $score, gameId: $gameId}';
  }

  //Player(this.playerId, this.playerName,  this.gameId, this.score);

  /// Retrieve from sqfLite
  void fromMap(Map<String, dynamic> map){
    this.playerId = map["id"];
    this.playerName = map["pseudo"];
    this.score = map["score"];
    this.gameId = map["gameId"];

  }

  /// To send data to database
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "pseudo" : this.playerName,
      "score" : this.score,
      "gameId" : this.gameId,
    };
    if(playerId != null){
      map['id'] = this.playerId;
    }
    return map;
  }
}