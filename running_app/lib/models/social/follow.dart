import 'package:running_app/models/account/activity.dart';

class Follow {
  final String? id;
  final String? followerId;
  final String? followeeId;

  Follow({
    this.id,
    required this.followerId,
    required this.followeeId,
  });

  Follow.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        followerId = json['follower_id'],
        followeeId = json['followee_id'];

  Map<String, dynamic> toJson() {
    return {
      'follower_id': followerId,
      'followee_id': followeeId,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}
