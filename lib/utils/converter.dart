class Converter {
  /// This function takes a nullable integer and returns its value multiplied
  /// by 10 if the value is less than 1000, otherwise it returns the original value.
  /// If the input is null, it returns null as well.
  ///
  /// @param number A nullable integer that needs to be converted to thousands.
  /// @return An integer that represents the converted value or null if the input is null.
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