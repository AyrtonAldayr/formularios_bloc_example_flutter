bool isNumeric(String s) {
  return s.isEmpty
      ? false
      : num.tryParse(s) == null
          ? false
          : true;
}
