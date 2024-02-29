import 'user.dart';
class Performance {
  final String? id;
  final User? user;
  final int? point;
  final int? level;
  final int? totalSteps;
  final int? stepsRemaining;

  Performance({
    required this.id,
    required this.user,
    required this.point,
    required this.level,
    required this.totalSteps,
    required this.stepsRemaining,
  });

  Performance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        point = json['point'],
        level = json['level'],
        totalSteps = json['total_steps'],
        stepsRemaining = json['steps_remaining'];

  @override
  String toString() {
    return 'Performance{id: $id, user: $user, point: $point, level: $level, total_steps: $totalSteps, steps_remaining: $stepsRemaining}';
  }
}

// class DetailPerformance {
//   Performance({
//
// })
// }

