import '../account/user.dart';

class Club {
  final String? id;
  final String? name;
  final String? avatar;
  final String? sportType;
  final int? weekActivities;
  final int? numberOfParticipants;

  Club({
     required this.id,
     required this.name,
     required this.avatar,
     required this.sportType,
     required this.weekActivities,
     required this.numberOfParticipants,
  });

  Club.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      avatar = json['avatar'],
      sportType = json['sport_type'],
      weekActivities = json['week_activities'],
      numberOfParticipants = json['number_of_participants'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'sport_type': sportType,
      'week_activities': weekActivities,
      'number_of_participants': numberOfParticipants,
    };
  }

  @override
  String toString() {
    return 'Club{id: $id, name: $name, avatar: $avatar, sportType: $sportType, weekActivities: $weekActivities, numberOfParticipants: $numberOfParticipants}';
  }
}

class DetailClub extends Club {
  final DetailUser users;
  final String? description;
  final bool? participateFreely;
  final String? organization;

  DetailClub({
    String? id,
    String? name,
    String? avatar,
    String? sportType,
    int? weekActivities,
    int? numberOfParticipants,
    required this.users,
    required this.description,
    required this.participateFreely,
    required this.organization
  }) : super(
    id: id,
    name: name,
    avatar: avatar,
    sportType: sportType,
    weekActivities: weekActivities,
    numberOfParticipants: numberOfParticipants
  );

  DetailClub.fromJson(Map<String, dynamic> json)
      : users = json['users'],
        description = json['description'],
        participateFreely = json['participate_freely'],
        organization = json['organization'],
        super(
          id: json['id'],
          name: json['name'],
          avatar: json['avatar'],
          sportType: json['sport_type'],
          weekActivities: json['week_activities'],
          numberOfParticipants: json['number_of_participants'],
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['users'] = users.toJson(); // Serialize DetailUser object
    data['description'] = description;
    data['participate_freely'] = participateFreely;
    data['organization'] = organization;
    return data;
  }

  @override
  String toString() {
    return 'DetailClub{${super.toString()}, users: $users, description: $description, participateFreely: $participateFreely, organization: $organization}';
  }
}