
abstract class UserParticipation {
  final String? userId;
  final bool? isAdmin;
  final String? participatedAt;

  UserParticipation({
    required this.userId,
    required this.isAdmin,
    required this.participatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'is_admin': isAdmin,
      'participated_at': participatedAt,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}

class UserParticipationClub extends UserParticipation {
  final String? clubId;

  UserParticipationClub({
    String? userId,
    bool? isAdmin,
    String? participatedAt,
    required this.clubId
  }) : super(
    userId: userId,
    isAdmin: isAdmin,
    participatedAt: participatedAt
  );

  // UserParticipationClub.fromJson(Map<String, dynamic> json)
  //     : club = CreateClub.fromJson(json['club']),
  //       super(
  //         user: User.fromJson(json['user']),
  //         isAdmin: json['is_admin'],
  //         participatedAt: json['participated_at'],
  //       );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['club_id'] = clubId;
    return data;
  }

  @override
  String toString() {
    return 'UserParticipationClub{${super.toString()}, club: $clubId}';
  }
}

class UserParticipationEvent extends UserParticipation {
  final String? eventId;
  final bool? isSuperAdmin;

  UserParticipationEvent({
    String? userId,
    bool? isAdmin,
    String? participatedAt,
    required this.isSuperAdmin,
    required this.eventId
  }) : super(
      userId: userId,
      isAdmin: isAdmin,
      participatedAt: participatedAt
  );

  // UserParticipationEvent.fromJson(Map<String, dynamic> json)
  //     : event = Event.fromJson(json['event']),
  //       super(
  //         user: User.fromJson(json['user']),
  //         isAdmin: json['is_admin'],
  //         participatedAt: json['participated_at'],
  //       );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['event_id'] = eventId;
    data['is_superadmin'] = isSuperAdmin;
    return data;
  }

  @override
  String toString() {
    return '${super.toJson()} ${toJson()}';
  }
}

class UserParticipationGroup extends UserParticipation {
  final String? groupId;

  UserParticipationGroup({
    String? userId,
    bool? isAdmin,
    String? participatedAt,
    required this.groupId
  }) : super(
      userId: userId,
      isAdmin: isAdmin,
      participatedAt: participatedAt
  );

  // UserParticipationGroup.fromJson(Map<String, dynamic> json)
  //     : group = CreateGroup.fromJson(json['group']),
  //       super(
  //         user: User.fromJson(json['user']),
  //         isAdmin: json['is_admin'],
  //         participatedAt: json['participated_at'],
  //       );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['group_id'] = groupId;
    return data;
  }

  @override
  String toString() {
    return 'UserParticipationGroup{${super.toString()}, group: $groupId}';
  }
}
