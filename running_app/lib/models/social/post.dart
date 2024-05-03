
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
  final String? updatedAt;
  String? checkUserLike;

  Post({
    required this.id,
    required this.user,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.checkUserLike,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = Author.fromJson(json['user']),
        title = json['title'],
        content = json['content'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        checkUserLike = json['check_user_like'];

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
    String? updatedAt,
    String? createdAt,
    String? checkUserLike,
    required this.likes,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      checkUserLike: checkUserLike
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
    String? updatedAt,
    String? checkUserLike,
    required this.likes,
    required this.totalLikes,
    required this.totalComments,
  }) : super(
      id: id,
      user: user,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      checkUserLike: checkUserLike
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

class CreateClubPost {
  final String? title;
  final String? content;
  final String? userId;
  final String? clubId;

  CreateClubPost({
    required this.userId,
    required this.clubId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'club_id': clubId,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}

class CreateEventPost {
  final String? title;
  final String? content;
  final String? userId;
  final String? eventId;

  CreateEventPost({
    required this.userId,
    required this.eventId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'event_id': eventId,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}


class UpdatePost {
  final String? title;
  final String? content;

  UpdatePost({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}


