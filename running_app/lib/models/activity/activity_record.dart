import '../account/user.dart';

class ActivityRecord {
  final String? id;
  final String? sportType;
  final double? distance;
  final int? step;
  final User? user;
  final double? kcal;
  final String? completedAt;

  ActivityRecord({
     required this.id,
     required this.sportType,
     required this.distance,
     required this.step,
     required this.user,
     required this.kcal,
     required this.completedAt,
  });

  ActivityRecord.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      sportType = json['sport_type'],
      distance = double.parse(json['distance']),
      step = json['step'],
      user = User.fromJson(json['user']),
      kcal = json['kcal'],
      completedAt = json['completed_at'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport_type': sportType,
      'distance': distance,
      'step': step,
      'user': user?.toJson(),
      'kcal': kcal,
      'completed_at': completedAt,
    };
  }

  @override
  String toString() {
    return 'ActivityRecord{id: $id, sportType: $sportType, distance: $distance, step: $step, user: $user, kcal: $kcal, completedAt: $completedAt}';
  }
}

class DetailActivityRecord extends ActivityRecord {
  final String? duration;
  final String? description;

  DetailActivityRecord({
    String? id,
    String? sportType,
    double? distance,
    int? step,
    User? user,
    double? kcal,
    String? completedAt,
    required this.duration,
    required this.description,
  }) : super(
    id: id,
    sportType: sportType,
    distance: distance,
    step: step,
    user: user,
    kcal: kcal,
    completedAt: completedAt,
  );

  DetailActivityRecord.fromJson(Map<String, dynamic> json)
    : duration = json['duration'],
      description = json['description'],
      super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['duration'] = duration;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'DetailActivityRecord{${super.toString()}, duration: $duration, description: $description}';
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