import 'package:running_app/models/account/activity.dart';

class Follow {
  final String? id; // Assuming there's an ID field for Follow in Django
  final Activity? follower;
  final Activity? followee;
  final DateTime createdAt;

  Follow({
    required this.id,
    required this.follower,
    required this.followee,
    required this.createdAt,
  });

  Follow.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        follower = Activity.fromJson(json['follower']),
        followee = Activity.fromJson(json['followee']),
        createdAt = DateTime.parse(json['created_at']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'follower': follower.toJson(),
      // 'followee': followee.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '$follower follows $followee';
  }
}
