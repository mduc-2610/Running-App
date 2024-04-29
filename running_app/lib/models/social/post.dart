
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
  final String? postLikeId;

  Post({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.postLikeId,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = Author.fromJson(json['user']),
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'],
        postLikeId = json['post_like_id'];

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
  int totalLikes;
  int totalComments;
  final List<Like>? likes;

  void increaseTotalLikes() {
    totalLikes += 1;
  }

  void increaseTotalComments() {
    totalComments += 1;
  }

  void decreaseTotalLikes() {
    totalLikes -= 1;
  }

  void decreaseTotalComments() {
    totalComments -= 1;
  }

  ClubPost({
    String? id,
    Author? user,
    String? title,
    String? content,
    String? createdAt,
    String? postLikeId,
    required this.likes,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt,
      postLikeId: postLikeId
  );

  ClubPost.fromJson(Map<String, dynamic> json)
      : likes = (json['likes'] as List<dynamic>)
        .map((likeJson) => Like.fromJson(likeJson))
        .toList(),
        totalLikes = json['total_likes'],
        totalComments = json['total_comments'],
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $totalLikes in $totalComments';
  }
}

class DetailClubPost extends ClubPost {
  final List<ClubPostComment>? comments;

  DetailClubPost({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    List<Like>? likes,
    required int totalLikes,
    required int totalComments,
    Author? user,
    required this.comments,
  }) : super(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      totalLikes: totalLikes,
      totalComments: totalComments,
      user: user,
      likes: likes
  );

  DetailClubPost.fromJson(Map<String, dynamic> json)
      : comments = (json['comments'] as List<dynamic>)
            .map((commentJson) => ClubPostComment.fromJson(commentJson))
            .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user $likes $comments';
  }
}

class EventPost extends Post {
  int totalLikes;
  int totalComments;
  final List<Like>? likes;

  void increaseTotalLikes() {
    totalLikes += 1;
  }

  void increaseTotalComments() {
    totalComments += 1;
  }

  void decreaseTotalLikes() {
    totalLikes -= 1;
  }

  void decreaseTotalComments() {
    totalComments -= 1;
  }

  EventPost({
    String? id,
    Author? user,
    String? title,
    String? content,
    String? createdAt,
    String? postLikeId,
    required this.likes,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt,
      postLikeId: postLikeId
  );

  EventPost.fromJson(Map<String, dynamic> json)
      : likes = (json['likes'] as List<dynamic>?)
          ?.map((likeJson) => Like.fromJson(likeJson))
          .toList(),
        totalLikes = json['total_likes'],
        totalComments = json['total_comments'],
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $totalLikes in $totalComments';
  }
}

class DetailEventPost extends EventPost {
  final List<EventPostComment>? comments;

  DetailEventPost({
    String? id,
    String? title,
    String? content,
    String? createdAt,
    List<Like>? likes,
    required int totalLikes,
    required int totalComments,
    Author? user,
    required this.comments,
  }) : super(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      totalLikes: totalLikes,
      totalComments: totalComments,
      user: user,
      likes: likes
  );

  DetailEventPost.fromJson(Map<String, dynamic> json)
      : comments = (json['comments'] as List<dynamic>?)
          ?.map((commentJson) => EventPostComment.fromJson(commentJson))
          .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user $likes $comments';
  }
}
