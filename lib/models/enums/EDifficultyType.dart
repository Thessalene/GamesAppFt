

enum EDifficultyType{
  EASY,
  MEDIUM,
  DIFFICULT,
  EXPERT
}

class EDifficultyTypeHelper{

  EDifficultyType getDifficultyTypeFromString(String type){
    EDifficultyType result;
    switch(type){
      case "Facile":
        result = EDifficultyType.EASY;
        break;
      case "Medium" :
        result = EDifficultyType.MEDIUM;
        break;
      case "Difficile":
        result =  EDifficultyType.DIFFICULT;
        break;
      case"Expert" :
        result = EDifficultyType.EXPERT;
        break;
      default:
        result = EDifficultyType.EASY;
        break;
    }
    return result;
  }

  String getStringFromDifficultyType(EDifficultyType type){
    String result;
    switch(type){
      case EDifficultyType.EASY:
        result = "Facile";
        break;
      case EDifficultyType.MEDIUM:
        result = "Medium";
        break;
      case EDifficultyType.DIFFICULT:
        result = "Difficile";
        break;
      case EDifficultyType.EXPERT:
        result = "Expert";
        break;
    }
    return result;
  }
}