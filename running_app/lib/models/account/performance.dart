import 'user.dart';

class Performance {
  final String? id;
  final User? user;
  final int? level;
  final int? stepsDoneThisLevel;
  final int? totalStepsThisLevel;
  final double? periodDistance;
  final int? periodSteps;
  final int? periodPoints;
  final String? periodDuration;
  final String? periodAvgMovingPace;
  final int? periodAvgTotalCadence;
  final int? periodAvgTotalHeartRate;
  final int? periodActiveDays;

  Performance({
    required this.id,
    required this.user,
    required this.level,
    required this.stepsDoneThisLevel,
    required this.totalStepsThisLevel,
    required this.periodDistance,
    required this.periodSteps,
    required this.periodPoints,
    required this.periodDuration,
    required this.periodAvgMovingPace,
    required this.periodAvgTotalCadence,
    required this.periodAvgTotalHeartRate,
    required this.periodActiveDays,
  });

  Performance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        level = json['level'],
        stepsDoneThisLevel = json['steps_done_this_level'],
        totalStepsThisLevel = json['total_steps_this_level'],
        periodDistance = json['period_distance'],
        periodSteps = json['period_steps'],
        periodPoints = json['period_points'],
        periodDuration = json['period_duration'],
        periodAvgMovingPace = json['period_avg_moving_pace'],
        periodAvgTotalCadence = json['period_avg_total_cadence'],
        periodAvgTotalHeartRate = json['period_avg_total_heart_rate'],
        periodActiveDays = json['period_active_days'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'level': level,
      'steps_done_this_level': stepsDoneThisLevel,
      'total_steps_this_level': totalStepsThisLevel,
      'period_distance': periodDistance,
      'period_steps': periodSteps,
      'period_points': periodPoints,
      'period_duration': periodDuration,
      'period_avg_moving_pace': periodAvgMovingPace,
      'period_avg_total_cadence': periodAvgTotalCadence,
      'period_avg_total_heart_rate': periodAvgTotalHeartRate,
      'period_active_days': periodActiveDays,
    };
  }

  @override
  String toString() {
    return 'Performance{'
        '${toJson()}'
        '}';
  }
}
