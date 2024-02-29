import '../account/user.dart';
import '../activity/club.dart';
import '../activity/event.dart';

abstract class UserParticipation {
  final User? user;
  final bool? isAdmin;
  final String? participatedAt;

  UserParticipation({
    required this.user,
    required this.isAdmin,
    required this.participatedAt
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'is_admin': isAdmin,
      'participated_at': participatedAt,
    };
  }
}

class UserParticipationClub extends UserParticipation {
  final Club? club;

  UserParticipationClub({
    User? user,
    bool? isAdmin,
    String? participatedAt,
    required this.club
  }) : super(
    user: user,
    isAdmin: isAdmin,
    participatedAt: participatedAt
  );

  UserParticipationClub.fromJson(Map<String, dynamic> json)
      : club = Club.fromJson(json['club']),
        super(
          user: User.fromJson(json['user']),
          isAdmin: json['is_admin'],
          participatedAt: json['participated_at'],
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['club'] = club?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'UserParticipationClub{${super.toString()}, club: $club}';
  }
}

class UserParticipationEvent extends UserParticipation {
  final Event? event;

  UserParticipationEvent({
    User? user,
    bool? isAdmin,
    String? participatedAt,
    required this.event
  }) : super(
      user: user,
      isAdmin: isAdmin,
      participatedAt: participatedAt
  );

  UserParticipationEvent.fromJson(Map<String, dynamic> json)
      : event = Event.fromJson(json['event']),
        super(
          user: User.fromJson(json['user']),
          isAdmin: json['is_admin'],
          participatedAt: json['participated_at'],
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['event'] = event?.toJson();
    return data;
  }

  @override
  String toString() {
    return 'UserParticipationEvent{${super.toString()}, event: $event}';
  }
}
