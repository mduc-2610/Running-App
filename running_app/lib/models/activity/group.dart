import '../account/user.dart';
import '../activity/event.dart';

class Group {
  final String? id;
  final String? name;
  final String? avatar;
  final int? totalDistance;
  final String? totalDuration;

  Group({
    required this.id,
    required this.name,
    required this.avatar,
    required this.totalDistance,
    required this.totalDuration
  });

  Group.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        totalDistance = json['total_distance'],
        totalDuration = json['total_duration'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'total_distance': totalDistance,
      'total_duration': totalDuration,
    };
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, avatar: $avatar, totalDistance: $totalDistance, totalDuration: $totalDuration}';
  }
}

class DetailGroup extends Group {
  final int? numberOfParticipants;
  final int? rank;
  final Event? event;
  final List<User>? users;
  final String? description;

  DetailGroup({
    String? id,
    String? name,
    String? avatar,
    int? totalDistance,
    String? totalDuration,
    required this.numberOfParticipants,
    required this.rank,
    required this.event,
    required this.users,
    required this.description
  }) : super(
    id: id,
    name: name,
    avatar: avatar,
    totalDistance: totalDistance,
    totalDuration: totalDuration,
  );

  DetailGroup.fromJson(Map<String, dynamic> json)
      : numberOfParticipants = json['number_of_participants'],
        rank = json['rank'],
        event = Event.fromJson(json['event']),
          users = (json['users'] as List<dynamic>).map((user) => User.fromJson(user)).toList(),
        description = json['description'],
        super(
          id: json['id'],
          name: json['name'],
          avatar: json['avatar'],
          totalDistance: json['total_distance'],
          totalDuration: json['total_duration'],
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['number_of_participants'] = numberOfParticipants;
    data['rank'] = rank;
    data['event'] = event?.toJson();
    data['users'] = users?.map((user) => user.toJson()).toList();
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'DetailGroup{${super.toString()}, numberOfParticipants: $numberOfParticipants, rank: $rank, event: $event, users: $users, description: $description}';
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