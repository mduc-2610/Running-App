import 'user.dart';
class Performance {
  final String? id;
  final User? user;
  final int? totalPoints;
  final int? level;
  final int? totalSteps;
  final int? totalStepsThisLevel;
  final int? stepsDoneThisLevel;

  Performance({
    required this.id,
    required this.user,
    required this.totalPoints,
    required this.level,
    required this.totalSteps,
    required this.stepsDoneThisLevel,
    required this.totalStepsThisLevel,
  });

  Performance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        totalPoints = json['total_points'],
        level = json['level'],
        totalSteps = json['total_steps'],
        stepsDoneThisLevel = json['steps_done_this_level'],
        totalStepsThisLevel = json['total_steps_this_level'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'total_points': totalPoints,
      'level': level,
      'total_steps': totalSteps,
      'steps_done_this_level': stepsDoneThisLevel,
      'total_steps_this_level': totalStepsThisLevel,
    };
  }

  @override
  String toString() {
    return 'Performance{id: $id, user: $user, totalPoints: $totalPoints, level: $level, total_steps: $totalSteps, steps_remaining: $stepsDoneThisLevel}';
  }
}

// class DetailPerformance {
//   Performance({
//
// })
// }

