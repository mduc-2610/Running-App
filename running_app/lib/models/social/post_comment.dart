import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/user_abbr.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';

class PostComment {
  final String? id;
  final UserAbbr? user;
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
        user = UserAbbr.fromJson(json['user']),
        content = json['content'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.id,
      'content': content,
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
    UserAbbr? user,
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    superJson['post_id'] = post;
    return superJson;
  }

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post}';
  }
}

class EventPostComment extends PostComment {
  final String? post;

  EventPostComment({
    String? id,
    UserAbbr? user,
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    superJson['post_id'] = post;
    return superJson;
  }

  @override
  String toString() {
    return '${user} - $createdAt - Post: ${post}';
  }
}

class ActivityRecordPostComment extends PostComment {
  final String? post;

  ActivityRecordPostComment({
    String? id,
    UserAbbr? user,
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> superJson = super.toJson();
    superJson['post_id'] = post;
    return superJson;
  }

  @override
  String toString() {
    return '${user} - $createdAt - Activity Record: ${post}';
  }
}

class CreatePostComment {
  final String? userId;
  final String? postId;
  final String? content;

  CreatePostComment({
    required this.userId,
    required this.postId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'post_id': postId,
      'content': content,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}