import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/social/post.dart';

class PostLike {
  final String? createdAt;

  PostLike({
    required this.createdAt,
  });

  PostLike.fromJson(Map<String, dynamic> json)
      : createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return '';
  }
}

class EventPostLike extends PostLike {
  final String? postId;
  final String? userId;

  EventPostLike({
    String? createdAt,
    required this.postId,
    required this.userId,
  }) : super(
      createdAt: createdAt
  );

  EventPostLike.fromJson(Map<String, dynamic> json)
      : postId = json['post_id'],
        userId = json['user_id'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return '$postId - $userId';
  }
}

class ClubPostLike extends PostLike {
  final String? postId;
  final String? userId;

  ClubPostLike({
    String? createdAt,
    required this.postId,
    required this.userId,
  }) : super(createdAt: createdAt);

  ClubPostLike.fromJson(Map<String, dynamic> json)
      : postId = json['post_id'],
        userId = json['user_id'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return '$postId - $userId';
  }
}

class ActivityRecordPostLike extends PostLike {
  final String? postId;
  final String? userId;

  ActivityRecordPostLike({
    String? createdAt,
    required this.postId,
    required this.userId,
  }) : super(createdAt: createdAt);

  ActivityRecordPostLike.fromJson(Map<String, dynamic> json)
      : postId = json['post_id'],
        userId = json['user_id'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
    };
  }

  @override
  String toString() {
    return '$postId - $userId';
  }
}

class CreatePostLike {
  final String? userId;
  final String? postId;

  CreatePostLike({
    required this.userId,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'post_id': postId,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}
