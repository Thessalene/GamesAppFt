

class Letter{
  String _letter;
  bool _selected = false;

  Letter(this._letter, this._selected);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Letter &&
              runtimeType == other.runtimeType &&
              _letter == other._letter;

  @override
  int get hashCode => _letter.hashCode;


  @override
  String toString() {
    return"$_letter : $_selected";
  }

  static List<Letter> convertStringListIntoLetterList(List<String> stringList){
    List<Letter> result = [];

    stringList.forEach((element) {
      result.add(Letter(element, false));
    });
    return result;
  }

  static List<Letter> generateLetterList(){
    return [
      Letter("A", false),
      Letter("B", false),
      Letter("C", false),
      Letter("D", false),
      Letter("E", false),
      Letter("F", false),
      Letter("G", false),
      Letter("H", false),
      Letter("I", false),
      Letter("J", false),
      Letter("K", false),
      Letter("L", false),
      Letter("M", false),
      Letter("N", false),
      Letter("O", false),
      Letter("P", false),
      Letter("Q", false),
      Letter("R", false),
      Letter("S", false),
      Letter("T", false),
      Letter("U", false),
      Letter("V", false),
      Letter("W", false),
      Letter("X", false),
      Letter("Y", false),
      Letter("Z", false),
    ];
  }

  /**
   * GETTER AND SETTER
   */

  set letter(String value) {
    _letter = value;
  }


  String get letter => _letter;

  set selected(bool value) {
    _selected = value;
  }

  bool get selected => _selected;


}