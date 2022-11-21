String createNewId() => DateTime.now().toIso8601String();

String getTwoDecimalDouble(String value) {
  for (int i = 0; i < value.length; i++) {
    if (value[i] == '.') {
      if (value.length == i + 2 && value[i + 1] == '0') {
        return value.substring(0, i);
      }
      return value.substring(0, i + 2);
    }
  }

  return value;
}
