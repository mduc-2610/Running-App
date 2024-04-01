String convertChoice(String x) {
  List<String> words = x.split(" ");
  String result = words.map((word) => word.toUpperCase()).join("_");
  return result;
}

String getUrlId(String x) {
  List<String> words = x.split("/");
  return words[words.length - 2];
}

String durationRepresentation(int duration) {
  int hours = duration ~/ 3600;
  int minutes = (duration % 3600) ~/ 60;
  int seconds = duration % 60;

  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

double paceCalculate(int duration, int distance) {
  return (duration / 60) / (distance / 1000);
}

String paceRepresentation(int duration, double distance) {
  double pace = (distance != 0) ? (duration / 60) / (distance / 1000) : 0;
  int paceMinutes = pace.floor();
  int paceSeconds = ((pace - paceMinutes.toDouble()) * 60).round();

  return '$paceMinutes:${paceSeconds.toString().padLeft(2, '0')}';
}

int countTextLines(String text) {
  int count = 0;
  List<String> textLines = text.split('\n');
  for(String line in textLines) {
    List<String> words = line.split(' ');
    print(words.length);
    count += (words.length / 9).ceil();
  }
  return count;
}