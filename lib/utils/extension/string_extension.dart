extension StringExtension on String? {
  String snakeCase() {
    if (this == null) {
      return '';
    }
    String result = this!.replaceAllMapped(RegExp('([A-Z])'),
        (Match match) => '_${match.group(0)?.toLowerCase()}');
    result = result.replaceAll(' ', '_').toLowerCase();
    if (result.startsWith('_')) {
      result = result.substring(1);
    }

    return result;
  }

  String toCamelCase() {
    if (this == null) {
      return '';
    }
    return this!.replaceAllMapped(RegExp(r'(^|[_\s])(\w)'),
        (Match match) => match.group(2)!.toUpperCase());
  }
}
