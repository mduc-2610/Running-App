String convertChoice(String x) {
  List<String> words = x.split(" ");
  String result = words.map((word) => word.toUpperCase()).join("_");
  return result;
}
