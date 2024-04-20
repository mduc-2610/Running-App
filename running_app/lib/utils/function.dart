import 'package:intl/intl.dart';

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

int countTextLines(String text, {int? charInLine}) {
  int count = 0;
  List<String> textLines = text.split('\n');
  charInLine = charInLine ?? 50;
  for(String line in textLines) {
    count += (line.length / charInLine).ceil();
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
  else if (type == 3) {
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    if (totalSeconds >= 3600) {
      int remainingMinutes = (totalSeconds % 3600) ~/ 60;
      return '${totalSeconds ~/ 3600}h${remainingMinutes}m';
    } else {
      return '${totalSeconds ~/ 60}m${totalSeconds % 60}s';
    }
  }
  return '$formattedHours H';
}

String formatDate(DateTime x) {
  return DateFormat('yyyy-MM-dd').format(x);
}

String formatDateTime(DateTime x) {
  return DateFormat('yyyy-MM-dd hh:mm').format(x);
}

String formatDateQuery(DateTime? date) {
  return DateFormat('yyyy-MM-dd').format(date!);
}

String formatDateTimeQuery(DateTime x) {
  return DateFormat('yyyy-MM-dd hh:mm').format(x);
}



String formatDateTimeEnUS(DateTime x, {bool shortcut = false, bool time = false, bool timeFirst = false}) {
  String monthFormat = shortcut ? 'MMM' : 'MMMM';
  String dateFormat = '$monthFormat dd, yyyy';
  String timeFormat = time ? 'hh:mm' : '';
  String format = '$dateFormat $timeFormat';
  if(timeFirst == true) {
    format = '$timeFormat $dateFormat';
  }
  return DateFormat('${format}', 'en_US').format(x);
}
