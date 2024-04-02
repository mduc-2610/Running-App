import '../account/user.dart';

class ActivityRecord {
  final String? id;
  final String? sportType;
  final String? distance;
  final int? pointsEarned;
  final int? steps;
  final int? kcal;
  final String? completedAt;
  final String? avgMovingPace;

  ActivityRecord({
     required this.id,
     required this.sportType,
     required this.distance,
     required this.steps,
     required this.pointsEarned,
     required this.kcal,
     required this.completedAt,
     required this.avgMovingPace,
  });

  ActivityRecord.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      sportType = json['sport_type'],
      distance = json['distance'].toString(),
      steps = json['steps'],
      pointsEarned = json['points_earned'],
      kcal = json['kcal'],
      completedAt = json['completed_at'],
      avgMovingPace = json['avg_moving_pace'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport_type': sportType,
      'distance': distance,
      'steps': steps,
      'points_earned': pointsEarned,
      'kcal': kcal,
      'completed_at': completedAt,
      'avgMovingPace': avgMovingPace,
    };
  }

  @override
  String toString() {
    return 'ActivityRecord{id: $id, sportType: $sportType, distance: $distance, steps: $steps, kcal: $kcal, completedAt: $completedAt}';
  }
}

class DetailActivityRecord extends ActivityRecord {
  final String? duration;
  final String? description;
  final User? user;
  DetailActivityRecord({
    String? id,
    String? sportType,
    String? distance,
    int? steps,
    int? pointsEarned,
    int? kcal,
    String? completedAt,
    String? avgMovingPace,
    required this.duration,
    required this.description,
    required this.user,
  }) : super(
    id: id,
    sportType: sportType,
    distance: distance,
    steps: steps,
    pointsEarned: pointsEarned,
    kcal: kcal,
    completedAt: completedAt,
    avgMovingPace: avgMovingPace
  );

  DetailActivityRecord.fromJson(Map<String, dynamic> json)
    : duration = json['duration'],
      description = json['description'],
      user = User.fromJson(json['user']),
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['duration'] = duration;
    data['description'] = description;
    data['user'] = user?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'DetailActivityRecord{${super.toString()}, duration: $duration, description: $description, user: $user}';
  }
}

class CreateActivityRecord {
  final double? distance;
  final String? duration;
  final String? sportType;
  final String? description;
  final String? user;

  CreateActivityRecord({
    required this.distance,
    required this.duration,
    required this.sportType,
    required this.description,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'sport_type': sportType,
      'description': description,
      'user': user,
    };
  }
}

class UpdateActivityRecord {
  final String? description;

  UpdateActivityRecord({required this.description});

  Map<String, dynamic> toJson() {
    return {
      'description': description
    };
  }
}