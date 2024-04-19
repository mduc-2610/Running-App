import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';

class PostComment {
  final String id; // Assuming UUIDField is mapped to a String UUID in Dart
  final Activity user;
  final String content;
  final DateTime createdAt;

  PostComment({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  PostComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = Activity.fromJson(json['user']),
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '$user - $createdAt';
  }
}

class ClubPostComment extends PostComment {
  final ClubPost post;

  ClubPostComment({
    required String id,
    required Activity user,
    required String content,
    required DateTime createdAt,
    required this.post,
  }) : super(id: id, user: user, content: content, createdAt: createdAt);

  ClubPostComment.fromJson(Map<String, dynamic> json)
      : post = ClubPost.fromJson(json['post']),
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post.id}';
  }
}

class EventPostComment extends PostComment {
  final EventPost post;

  EventPostComment({
    required String id,
    required Activity user,
    required String content,
    required DateTime createdAt,
    required this.post,
  }) : super(id: id, user: user, content: content, createdAt: createdAt);

  EventPostComment.fromJson(Map<String, dynamic> json)
      : post = EventPost.fromJson(json['post']),
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post.id}';
  }
}

class ActivityRecordPostComment extends PostComment {
  final ActivityRecord post;

  ActivityRecordPostComment({
    required String id,
    required Activity user,
    required String content,
    required DateTime createdAt,
    required this.post,
  }) : super(id: id, user: user, content: content, createdAt: createdAt);

  ActivityRecordPostComment.fromJson(Map<String, dynamic> json)
      : post = ActivityRecord.fromJson(json['post']),
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Activity Record: ${post.id}';
  }
}
