import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/author.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';

class PostComment {
  final String? id;
  final Author? user;
  final String? content;
  final String? createdAt;

  PostComment({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  PostComment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = Author.fromJson(json['user']),
        content = json['content'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'content': content,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return '$user - $createdAt';
  }
}

class ClubPostComment extends PostComment {
  final String? post;

  ClubPostComment({
    String? id,
    Author? user,
    String? content,
    String? createdAt,
    required this.post,
  }) : super(
      id: id,
      user: user,
      content: content,
      createdAt: createdAt);

  ClubPostComment.fromJson(Map<String, dynamic> json)
      : post = json['post'],
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post}';
  }
}

class EventPostComment extends PostComment {
  final String? post;

  EventPostComment({
    String? id,
    Author? user,
    String? content,
    String? createdAt,
    required this.post,
  }) : super(
      id: id,
      user: user,
      content: content,
      createdAt: createdAt
  );

  EventPostComment.fromJson(Map<String, dynamic> json)
      : post = json['post'],
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post}';
  }
}

class ActivityRecordPostComment extends PostComment {
  final String? post;

  ActivityRecordPostComment({
    String? id,
    Author? user,
    String? content,
    String? createdAt,
    required this.post,
  }) : super(
      id: id,
      user: user,
      content: content,
      createdAt: createdAt
  );

  ActivityRecordPostComment.fromJson(Map<String, dynamic> json)
      : post = json['post'],
        super.fromJson(json);

  @override
  String toString() {
    return '${user} - $createdAt - Activity Record: ${post}';
  }
}
