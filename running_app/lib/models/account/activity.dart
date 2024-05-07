
import "package:running_app/models/account/user_abbr.dart";
import "package:running_app/models/activity/club.dart";
import "package:running_app/models/activity/activity_record.dart";
import "package:running_app/models/activity/event.dart";
import "package:running_app/models/product/product.dart";
import "package:running_app/models/social/post.dart";
import "package:running_app/models/social/post_comment.dart";
import "package:running_app/models/social/post_image.dart";
import 'package:running_app/view/community/utils/common_widgets/activity_record_post.dart';

import "user.dart";

class Activity {
  final String? id;
  // final User? user;
  int totalFollowers;
  int totalFollowees;
  int totalEventJoined;
  int totalEndedEventJoined;
  String? checkUserFollow;
  final List<UserAbbr>? followers;
  final List<UserAbbr>? followees;
  final List<Product>? products;
  final List<Event>? events;
  final List<Club>? clubs;
  final List<DetailActivityRecord>? activityRecords;
  final List<DetailActivityRecord>? followingActivityRecords;
  final List<ClubPost>? clubPostLikes;
  final List<EventPost>? eventPostLikes;
  final List<ActivityRecord>? activityRecordPostLikes;
  final List<ClubPostComment>? clubPostComments;
  final List<EventPostComment>? eventPostComments;
  final List<ActivityRecordPostComment>? activityRecordPostComments;

  Activity({
    required this.id,
    // required this.user,
    required this.totalFollowers,
    required this.totalFollowees,
    required this.totalEventJoined,
    required this.totalEndedEventJoined,
    this.checkUserFollow,
    required this.followers,
    required this.followees,
    required this.products,
    required this.events,
    required this.clubs,
    required this.activityRecords,
    required this.followingActivityRecords,
    required this.clubPostLikes,
    required this.eventPostLikes,
    required this.activityRecordPostLikes,
    required this.clubPostComments,
    required this.eventPostComments,
    required this.activityRecordPostComments,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        // user = User.fromJson(json["user"]),
        totalFollowers = json["total_followers"],
        totalFollowees = json["total_followees"],
        totalEventJoined = json["total_event_joined"],
        totalEndedEventJoined = json["total_ended_event_joined"],
        checkUserFollow = json["check_user_follow"],
        followers = (json["followers"] as List<dynamic>?)?.map((e) => UserAbbr.fromJson(e)).toList(),
        followees = (json["followees"] as List<dynamic>?)?.map((e) => UserAbbr.fromJson(e)).toList(),
        products = (json["products"] as List<dynamic>?)?.map((e) => Product.fromJson(e)).toList(),
        events = (json["events"] as List<dynamic>?)?.map((e) => Event.fromJson(e)).toList(),
        clubs = (json["clubs"] as List<dynamic>?)?.map((e) => Club.fromJson(e)).toList(),
        activityRecords = (json["activity_records"] as List<dynamic>?)?.map((e) => DetailActivityRecord.fromJson(e)).toList(),
        followingActivityRecords = (json["following_activity_records"] as List<dynamic>?)?.map((e) => DetailActivityRecord.fromJson(e)).toList(),
        clubPostLikes = (json["club_post_likes"] as List<dynamic>?)?.map((e) => ClubPost.fromJson(e)).toList(),
        eventPostLikes = (json["event_post_likes"] as List<dynamic>?)?.map((e) => EventPost.fromJson(e)).toList(),
        activityRecordPostLikes = (json["activity_record_post_likes"] as List<dynamic>?)?.map((e) => ActivityRecord.fromJson(e)).toList(),
        clubPostComments = (json["club_post_comments"] as List<dynamic>?)?.map((e) => ClubPostComment.fromJson(e)).toList(),
        eventPostComments = (json["event_post_comments"] as List<dynamic>?)?.map((e) => EventPostComment.fromJson(e)).toList(),
        activityRecordPostComments = (json["activity_record_post_comments"] as List<dynamic>?)?.map((e) => ActivityRecordPostComment.fromJson(e)).toList();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      // "user": user?.toJson(),
      "products": products?.map((product) => product.toJson()).toList(),
      "events": events?.map((event) => event.toJson()).toList(),
      "clubs": clubs?.map((club) => club.toJson()).toList(),
      "activity_records": activityRecords?.map((record) => record.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Activity{id: $id, totalFollowers: $totalFollowers, totalFollowees: $totalFollowees, '
        'totalEventJoined: $totalEventJoined, totalEndedEventJoined: $totalEndedEventJoined, '
        'checkUserFollow: $checkUserFollow, followers: $followers, followees: $followees, '
        'products: $products, events: $events, clubs: $clubs, activityRecords: $activityRecords, '
        'followingActivityRecords: $followingActivityRecords, clubPostLikes: $clubPostLikes, '
        'eventPostLikes: $eventPostLikes, activityRecordPostLikes: $activityRecordPostLikes, '
        'clubPostComments: $clubPostComments, eventPostComments: $eventPostComments, '
        'activityRecordPostComments: $activityRecordPostComments}';
  }
}
