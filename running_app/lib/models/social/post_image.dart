
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';

class PostLike {
  final DateTime createdAt;

  PostLike({
    required this.createdAt,
  });

  PostLike.fromJson(Map<String, dynamic> json)
      : createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '';
  }
}

class EventPostLike extends PostLike {
  final EventPost post;
  final Activity user;

  EventPostLike({
    required DateTime createdAt,
    required this.post,
    required this.user,
  }) : super(createdAt: createdAt);

  EventPostLike.fromJson(Map<String, dynamic> json)
      : post = EventPost.fromJson(json['post']),
        user = Activity.fromJson(json['user']),
        super.fromJson(json);

  @override
  String toString() {
    return '$post - $user';
  }
}

class ClubPostLike extends PostLike {
  final ClubPost post;
  final Activity user;

  ClubPostLike({
    required DateTime createdAt,
    required this.post,
    required this.user,
  }) : super(createdAt: createdAt);

  ClubPostLike.fromJson(Map<String, dynamic> json)
      : post = ClubPost.fromJson(json['post']),
        user = Activity.fromJson(json['user']),
        super.fromJson(json);

  @override
  String toString() {
    return '$post - $user';
  }
}

class ActivityRecordPostLike extends PostLike {
  final ActivityRecord post;
  final Activity user;

  ActivityRecordPostLike({
    required DateTime createdAt,
    required this.post,
    required this.user,
  }) : super(createdAt: createdAt);

  ActivityRecordPostLike.fromJson(Map<String, dynamic> json)
      : post = ActivityRecord.fromJson(json['post']),
        user = Activity.fromJson(json['user']),
        super.fromJson(json);

  @override
  String toString() {
    return '$post - $user';
  }
}
