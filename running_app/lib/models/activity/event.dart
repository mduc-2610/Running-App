class Event {
  final String? id;
  final String? name;
  final int? numberOfParticipants;
  final String? banner;
  final String? daysRemaining;

  Event({
    required this.id,
    required this.name,
    required this.numberOfParticipants,
    required this.banner,
    required this.daysRemaining,
  });

  Event.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      numberOfParticipants = json['number_of_participants'],
      banner = json['banner'],
      daysRemaining = json['days_remaining'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number_of_participants': numberOfParticipants,
      'banner': banner,
      'days_remaining': daysRemaining,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, name: $name, numberOfParticipants: $numberOfParticipants, banner: $banner, daysRemaining: $daysRemaining}';
  }
}

class DetailEvent extends Event {
  final List<Map<String, dynamic>>? users;
  final String? startedAt;
  final String? endedAt;
  final Map<String, dynamic>? regulations;
  final String? description;
  final String? contactInformation;
  final String? sportType;
  final bool? isGroup;

  DetailEvent({
    String? id,
    String? name,
    int? numberOfParticipants,
    String? banner,
    String? daysRemaining,
    required this.users,
    required this.startedAt,
    required this.endedAt,
    required this.regulations,
    required this.description,
    required this.contactInformation,
    required this.sportType,
    required this.isGroup
  }) : super(
    id: id,
    name: name,
    numberOfParticipants: numberOfParticipants,
    banner: banner,
    daysRemaining: daysRemaining
  );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['users'] = users;
    data['started_at'] = startedAt;
    data['ended_at'] = endedAt;
    data['regulations'] = regulations;
    data['description'] = description;
    data['contact_information'] = contactInformation;
    data['sport_type'] = sportType;
    data['is_group'] = isGroup;
    return data;
  }

  DetailEvent.fromJson(Map<String, dynamic> json)
      : users = json['users'],
        startedAt = json['started_at'],
        endedAt = json['ended_at'],
        regulations = json['regulations'],
        description = json['description'],
        contactInformation = json['contact_information'],
        sportType = json['sport_type'],
        isGroup = json['is_group'],
        super(
          id: json['id'],
          name: json['name'],
          numberOfParticipants: json['number_of_participants'],
          banner: json['banner'],
          daysRemaining: json['days_remaining']
        );

  @override
  String toString() {
    return 'DetailEvent{${super.toString()}, users: $users, startedAt: $startedAt, endedAt: $endedAt, regulations: $regulations, description: $description, contactInformation: $contactInformation, sportType: $sportType, isGroup: $isGroup}';
  }
}