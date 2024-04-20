
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/author.dart';
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/event.dart';
import 'package:running_app/models/social/post_comment.dart';

class Post {
  final String? id;
  final Author? user;
  final String? title;
  final String? content;
  final String? createdAt;

  Post({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = Author.fromJson(json['user']),
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'title': title,
      'content': content,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}

class ClubPost extends Post {
  final int? totalLikes;
  final int? totalComments;

  ClubPost({
    String? id,
    Author? user,
    String? title,
    String? content,
    String? createdAt,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt
  );

  ClubPost.fromJson(Map<String, dynamic> json)
      : totalLikes = json['total_likes'],
        totalComments = json['total_comments'],
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $totalLikes in $totalComments';
  }
}

class DetailClubPost extends ClubPost {
  final List<Like>? likes;
  final List<ClubPostComment>? comments;

  DetailClubPost({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    int? totalLikes,
    int? totalComments,
    Author? user,
    required this.likes,
    required this.comments,
  }) : super(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      totalLikes: totalLikes,
      totalComments: totalComments,
      user: user
  );

  DetailClubPost.fromJson(Map<String, dynamic> json)
      : likes = (json['likes'] as List<dynamic>)
            .map((likeJson) => Like.fromJson(likeJson))
            .toList(),
        comments = (json['comments'] as List<dynamic>)
            .map((commentJson) => ClubPostComment.fromJson(commentJson))
            .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user $likes $comments';
  }
}

class EventPost extends Post {
  final int? totalLikes;
  final int? totalComments;

  EventPost({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    Author? user,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt
  );

  EventPost.fromJson(Map<String, dynamic> json)
      : totalLikes = json['total_likes'],
        totalComments = json['total_comments'],
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $totalLikes in $totalComments';
  }
}


class DetailEventPost extends ClubPost {
  final List<Like>? likes;
  final List<ClubPostComment>? comments;

  DetailEventPost({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    int? totalLikes,
    int? totalComments,
    Author? user,
    required this.likes,
    required this.comments,
  }) : super(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    totalLikes: totalLikes,
    totalComments: totalComments,
    user: user
  );

  DetailEventPost.fromJson(Map<String, dynamic> json)
      : likes = (json['likes'] as List<dynamic>)
            .map((likeJson) => Like.fromJson(likeJson))
            .toList(),
        comments = (json['comments'] as List<dynamic>)
            .map((commentJson) => ClubPostComment.fromJson(commentJson))
            .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user $likes $comments';
  }
}
