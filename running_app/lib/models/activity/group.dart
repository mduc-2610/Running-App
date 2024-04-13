import 'package:running_app/models/account/leaderboard.dart';

import '../account/user.dart';
import '../activity/event.dart';

class Group {
  final String? id;
  final String? name;
  final String? avatar;
  final int? totalDistance;
  final String? totalDuration;
  final int? numberOfParticipants;

  Group({
    required this.id,
    required this.name,
    required this.avatar,
    required this.totalDistance,
    required this.totalDuration,
    required this.numberOfParticipants,
  });

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        numberOfParticipants = json['number_of_participants'],
        totalDistance = json['total_distance'],
        totalDuration = json['total_duration'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'number_of_participants': numberOfParticipants,
      'total_distance': totalDistance,
      'total_duration': totalDuration,
    };
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, avatar: $avatar, numberOfParticipants: $numberOfParticipants, totalDistance: $totalDistance, totalDuration: $totalDuration}';
  }
}

class DetailGroup extends Group {
  final int? rank;
  // final Event? event;
  final List<Leaderboard>? users;
  final String? description;

  DetailGroup({
    String? id,
    String? name,
    String? avatar,
    int? totalDistance,
    String? totalDuration,
    int? numberOfParticipants,
    required this.rank,
    // required this.event,
    required this.users,
    required this.description
  }) : super(
    id: id,
    name: name,
    avatar: avatar,
    numberOfParticipants: numberOfParticipants,
    totalDistance: totalDistance,
    totalDuration: totalDuration,
  );

  DetailGroup.fromJson(Map<String, dynamic> json)
      : rank = json['rank'],
        // event = Event.fromJson(json['event']),
        users = (json['users'] as List<dynamic>).map((user) => Leaderboard.fromJson(user)).toList(),
        description = json['description'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['rank'] = rank;
    // data['event'] = event?.toJson();
    data['users'] = users?.map((user) => user.toJson()).toList();
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'DetailGroup{${super.toString()}, rank: $rank, event: , users: $users, description: $description}';
  }
}

class CreateGroup {
  final String? name;
  final String? description;
  final String? avatar;
  final String? banner;
  final String? eventId;

  CreateGroup({
    required this.name,
    required this.description,
    required this.eventId,
    this.avatar,
    this.banner,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'avatar': avatar,
      'banner': banner,
      'event_id': eventId,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}