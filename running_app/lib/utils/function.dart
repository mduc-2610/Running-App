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
    count += (line.length / 47).ceil();
  }
  return count;
}

String idSubstring(String id) {
  List idList = id.split('-');
  return '${idList[idList.length - 1].substring(0, 6).toUpperCase()}';
}

String formatTimeDuration(String timeDuration, {int type = 1}) {
  List<String> parts = timeDuration.split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2]);

  double totalHours = hours + (minutes / 60) + (seconds / 3600);
  String formattedHours = totalHours.toStringAsFixed(1);
  formattedHours = formattedHours.replaceAll('.', ',');
  if(type == 2) {
    return '${parts[0]}h${parts[1]}m';
  }
  return '$formattedHours H';
}