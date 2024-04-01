
import 'package:running_app/models/activity/club.dart';
import 'package:running_app/models/activity/activity_record.dart';
import 'package:running_app/models/product/product.dart';

import 'user.dart';
import '../activity/event.dart';

class Activity {
  final String? id;
  final User? user;
  final List<Product> products;
  final List<Event> events;
  final List<Club> clubs;
  final List<ActivityRecord> activityRecords;

  Activity({
    required this.id,
    required this.user,
    required this.products,
    required this.events,
    required this.clubs,
    required this.activityRecords,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['user']),
        products = (json['products'] as List<dynamic>).map((e) => Product.fromJson(e)).toList(),
        events = (json['events'] as List<dynamic>).map((e) => Event.fromJson(e)).toList(),
        clubs = (json['clubs'] as List<dynamic>).map((e) => Club.fromJson(e)).toList(),
        activityRecords = (json['activity_records'] as List<dynamic>).map((e) => ActivityRecord.fromJson(e)).toList();

  @override
  String toString() {
    return 'Activity{id: $id, user: $user, point: $products, level: $events, total_steps: $clubs, activityRecords: $activityRecords}';
  }
}
