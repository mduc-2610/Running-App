import 'user.dart';
class Performance {
  final String? id;
  final User? user;
  final int? point;
  final int? level;
  final int? totalSteps;
  final int? totalStepsThisLevel;
  final int? stepsDoneThisLevel;

  Performance({
    required this.id,
    required this.user,
    required this.point,
    required this.level,
    required this.totalSteps,
    required this.stepsDoneThisLevel,
    required this.totalStepsThisLevel,
  });

  Performance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        point = json['point'],
        level = json['level'],
        totalSteps = json['total_steps'],
        stepsDoneThisLevel = json['steps_done_this_level'],
        totalStepsThisLevel = json['total_steps_this_level'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'point': point,
      'level': level,
      'total_steps': totalSteps,
      'steps_done_this_level': stepsDoneThisLevel,
      'total_steps_this_level': totalStepsThisLevel,
    };
  }

  @override
  String toString() {
    return 'Performance{id: $id, user: $user, point: $point, level: $level, total_steps: $totalSteps, steps_remaining: $stepsDoneThisLevel}';
  }
}

// class DetailPerformance {
//   Performance({
//
// })
// }

