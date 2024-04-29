
import 'package:running_app/models/account/like.dart';
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/product/product.dart';
import 'package:running_app/models/social/post.dart';
import 'package:running_app/models/social/post_comment.dart';
import 'package:running_app/models/social/post_image.dart';
import 'package:running_app/view/community/feed/utils/common_widget/activity_record_post.dart';

import 'user.dart';
import '../activity/event.dart';

class Activity {
  final String? id;
  // final User? user;
  final List<Product>? products;
  final List<Event>? events;
  final List<Club>? clubs;
  final List<ActivityRecord>? activityRecords;
  final List<ClubPost>? clubPostLikes;
  final List<EventPost>? eventPostLikes;
  final List<ActivityRecord>? activityRecordPostLikes;
  final List<ClubPostComment>? clubPostComments;
  final List<EventPostComment>? eventPostComments;
  final List<ActivityRecordPostComment>? activityRecordPostComments;

  Activity({
    required this.id,
    // required this.user,
    required this.products,
    required this.events,
    required this.clubs,
    required this.activityRecords,
    required this.clubPostLikes,
    required this.eventPostLikes,
    required this.activityRecordPostLikes,
    required this.clubPostComments,
    required this.eventPostComments,
    required this.activityRecordPostComments,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        // user = User.fromJson(json['user']),
        products = (json['products'] as List<dynamic>?)?.map((e) => Product.fromJson(e)).toList(),
        events = (json['events'] as List<dynamic>?)?.map((e) => Event.fromJson(e)).toList(),
        clubs = (json['clubs'] as List<dynamic>?)?.map((e) => Club.fromJson(e)).toList(),
        activityRecords = (json['activity_records'] as List<dynamic>?)?.map((e) => ActivityRecord.fromJson(e)).toList(),
        clubPostLikes = (json['club_post_likes'] as List<dynamic>?)?.map((e) => ClubPost.fromJson(e)).toList(),
        eventPostLikes = (json['event_post_likes'] as List<dynamic>?)?.map((e) => EventPost.fromJson(e)).toList(),
        activityRecordPostLikes = (json['activity_record_post_likes'] as List<dynamic>?)?.map((e) => ActivityRecord.fromJson(e)).toList(),
        clubPostComments = (json['club_post_comments'] as List<dynamic>?)?.map((e) => ClubPostComment.fromJson(e)).toList(),
        eventPostComments = (json['event_post_comments'] as List<dynamic>?)?.map((e) => EventPostComment.fromJson(e)).toList(),
        activityRecordPostComments = (json['activity_record_post_comments'] as List<dynamic>?)?.map((e) => ActivityRecordPostComment.fromJson(e)).toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'user': user?.toJson(),
      'products': products?.map((product) => product.toJson()).toList(),
      'events': events?.map((event) => event.toJson()).toList(),
      'clubs': clubs?.map((club) => club.toJson()).toList(),
      'activity_records': activityRecords?.map((record) => record.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Activity{id: $id, user: , point: $products, level: $events, total_steps: $clubs, activityRecords: $activityRecords activityRecordPostLikes: $activityRecordPostLikes, activityRecordPostComments: $activityRecordPostComments}';
  }
}
