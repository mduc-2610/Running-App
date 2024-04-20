import 'package:running_app/models/account/author.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/social/post_comment.dart';

import '../account/user.dart';

class ActivityRecord {
  final String? id;
  final String? title;
  final String? sportType;
  final String? privacy;
  final String? distance;
  final int? points;
  final int? steps;
  final int? kcal;
  final String? completedAt;
  final String? avgMovingPace;
  final Author? user;
  final int? totalLikes;
  final int? totalComments;

  ActivityRecord({
     required this.title,
     required this.id,
     required this.sportType,
     required this.privacy,
     required this.distance,
     required this.steps,
     required this.points,
     required this.kcal,
     required this.completedAt,
     required this.avgMovingPace,
     required this.user,
     required this.totalLikes,
     required this.totalComments,
  });

  ActivityRecord.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      sportType = json['sport_type'],
      privacy = json['privacy'],
      distance = json['distance'].toString(),
      steps = json['steps'],
      points = json['points'],
      kcal = json['kcal'],
      user = Author.fromJson(json['user']),
      completedAt = json['completed_at'],
      avgMovingPace = json['avg_moving_pace'],
      totalLikes = json['total_likes'],
      totalComments = json['total_comments'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sport_type': sportType,
      'privacy': privacy,
      'distance': distance,
      'steps': steps,
      'points_earned': points,
      'kcal': kcal,
      'completed_at': completedAt,
      'avg_moving_pace': avgMovingPace,
      'user': user,
      'total_likes': totalLikes,
      'total_comments': totalComments,
    };
  }

  @override
  String toString() {
    return 'ActivityRecord{id: $id, sportType: $sportType, privacy: $privacy, distance: $distance, steps: $steps, kcal: $kcal, completedAt: $completedAt}';
  }
}

class DetailActivityRecord extends ActivityRecord {
  final String? duration;
  final String? description;
  final List<Like>? likes;
  final List<ActivityRecordPostComment>? comments;

  DetailActivityRecord({
    String? id,
    String? title,
    String? sportType,
    String? privacy,
    String? distance,
    int? steps,
    int? points,
    int? kcal,
    String? completedAt,
    String? avgMovingPace,
    Author? user,
    int? totalLikes,
    int? totalComments,
    required this.duration,
    required this.description,
    required this.likes,
    required this.comments,
  }) : super(
    id: id,
    title: title,
    sportType: sportType,
    privacy: privacy,
    distance: distance,
    steps: steps,
    points: points,
    kcal: kcal,
    completedAt: completedAt,
    avgMovingPace: avgMovingPace,
    user: user,
    totalLikes: totalLikes,
    totalComments: totalComments,
  );

  DetailActivityRecord.fromJson(Map<String, dynamic> json)
    : duration = json['duration'],
      description = json['description'],
      likes = (json['likes'] as List<dynamic>)
        .map((likeJson) => Like.fromJson(likeJson))
        .toList(),
      comments = (json['comments'] as List<dynamic>)
        .map((commentJson) => ActivityRecordPostComment.fromJson(commentJson))
        .toList(),
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
  final String? privacy;
  final double? distance;
  final String? duration;
  final String? sportType;
  final String? title;
  final String? description;
  final String? userId;
  final String? completedAt;

  CreateActivityRecord({
    required this.privacy,
    required this.distance,
    required this.duration,
    required this.sportType,
    required this.title,
    required this.description,
    required this.userId,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'privacy': privacy,
      'distance': distance,
      'duration': duration,
      'sport_type': sportType,
      'title': title,
      'description': description,
      'completed_at': completedAt,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}

class UpdateActivityRecord {
  final String? title;
  final String? description;
  final String? privacy;

  UpdateActivityRecord({
    required this.title,
    required this.description,
    required this.privacy,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'privacy': privacy
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}