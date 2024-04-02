
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(), // Convert User object to JSON
      'products': products.map((product) => product.toJson()).toList(), // Convert List<Product> to JSON
      'events': events.map((event) => event.toJson()).toList(), // Convert List<Event> to JSON
      'clubs': clubs.map((club) => club.toJson()).toList(), // Convert List<Club> to JSON
      'activity_records': activityRecords.map((record) => record.toJson()).toList(), // Convert List<ActivityRecord> to JSON
    };
  }

  @override
  String toString() {
    return 'Activity{id: $id, user: $user, point: $products, level: $events, total_steps: $clubs, activityRecords: $activityRecords}';
  }
}
