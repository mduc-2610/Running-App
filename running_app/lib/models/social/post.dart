
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/event.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return title;
  }
}

class ClubPost extends Post {
  final Club club;
  final Activity user;
  final List<Activity> likes; // Assuming many-to-many relationship with Activity

  ClubPost({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required this.club,
    required this.user,
    required this.likes,
  }) : super(id: id, title: title, content: content, createdAt: createdAt);

  ClubPost.fromJson(Map<String, dynamic> json)
      : club = Club.fromJson(json['club']),
        user = Activity.fromJson(json['user']),
        likes = (json['likes'] as List<dynamic>)
            .map((likeJson) => Activity.fromJson(likeJson))
            .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user in $club';
  }
}

class EventPost extends Post {
  final Event? event;
  final Activity? user;
  final List<Activity>? likes; // Assuming many-to-many relationship with Activity

  EventPost({
    required String id,
    required String title,
    required String content,
    required DateTime createdAt,
    required this.event,
    required this.user,
    required this.likes,
  }) : super(id: id, title: title, content: content, createdAt: createdAt);

  EventPost.fromJson(Map<String, dynamic> json)
      : event = Event.fromJson(json['event']),
        user = Activity.fromJson(json['user']),
        likes = (json['likes'] as List<dynamic>)
            .map((likeJson) => Activity.fromJson(likeJson))
            .toList(),
        super.fromJson(json);

  @override
  String toString() {
    return '$title by $user in $event';
  }
}
