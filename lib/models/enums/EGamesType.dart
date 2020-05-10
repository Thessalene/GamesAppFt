
enum EGameType { TIC_TAC_TOE, BATTLESHIP, HANGED }

class EGameTypeHelper {

  String getNameFromType(EGameType type) {
    String result;
    switch (type) {
      case EGameType.TIC_TAC_TOE:
        result = "Tic Tac Toe";
        break;
      case EGameType.BATTLESHIP:
        result = "Battleship";
        break;
      case EGameType.HANGED:
        return "Hanged";
        break;
    }
    return result;
  }

  int getPlayerNbFromType(EGameType type) {
    int result;
    switch (type) {
      case EGameType.TIC_TAC_TOE:
        result = 2;
        break;
      case EGameType.BATTLESHIP:
        result = 2;
        break;
      case EGameType.HANGED:
        return 1;
        break;
    }
    return result;
  }
}
