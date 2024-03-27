String convertChoice(String x) {
  List<String> words = x.split(" ");
  String result = words.map((word) => word.toUpperCase()).join("_");
  return result;
}

String getUrlId(String x) {
  List<String> words = x.split("/");
  return words[words.length - 2];
}