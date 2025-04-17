class Converter {
  static int? convertToThousands(int? number) {
    if (number != null) {
      if (number < 1000) {
        return number * 10;
      } else {
        return number;
      }
    }
    return null;
  }
}