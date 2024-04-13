import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/models/activity/group.dart';

class Event {
  final String? id;
  final String? name;
  final int? numberOfParticipants;
  final String? banner;
  final int? daysRemain;

  Event({
    required this.id,
    required this.name,
    required this.numberOfParticipants,
    required this.banner,
    required this.daysRemain,
  });

  Event.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      numberOfParticipants = json['number_of_participants'],
      banner = json['banner'],
      daysRemain = json['days_remaining'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number_of_participants': numberOfParticipants,
      'banner': banner,
      'days_remaining': daysRemain,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, name: $name, numberOfParticipants: $numberOfParticipants, banner: $banner, daysRemain: $daysRemain}';
  }
}

class DetailEvent extends Event {
  final String? startedAt;
  final String? endedAt;
  final Map<String, dynamic>? regulations;
  final String? description;
  final String? contactInformation;
  final String? sportType;
  final String? privacy;
  final String? competition;
  final List<Leaderboard>? participants;
  final List<Group>? groups;

  DetailEvent({
    String? id,
    String? name,
    int? numberOfParticipants,
    String? banner,
    int? daysRemain,
    required this.startedAt,
    required this.endedAt,
    required this.regulations,
    required this.description,
    required this.contactInformation,
    required this.sportType,
    required this.privacy,
    required this.competition,
    required this.participants,
    required this.groups,
  }) : super(
    id: id,
    name: name,
    numberOfParticipants: numberOfParticipants,
    banner: banner,
    daysRemain: daysRemain
  );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['started_at'] = startedAt;
    data['ended_at'] = endedAt;
    data['regulations'] = regulations;
    data['description'] = description;
    data['contact_information'] = contactInformation;
    data['sport_type'] = sportType;
    data['privacy'] = privacy;
    data['competition'] = competition;
    data['participants'] = participants;
    data['groups'] = groups;
    return data;
  }

  DetailEvent.fromJson(Map<String, dynamic> json)
      : startedAt = json['started_at'],
        endedAt = json['ended_at'],
        regulations = json['regulations'],
        description = json['description'],
        contactInformation = json['contact_information'],
        sportType = json['sport_type'],
        privacy = json['privacy'],
        competition = json['competition'],
        participants = (json['participants'] as List<dynamic>).map((e) => Leaderboard.fromJson(e)).toList(),
        groups = (json['groups'] as List<dynamic>).map((e) => Group.fromJson(e)).toList(),
        super(
          id: json['id'],
          name: json['name'],
          numberOfParticipants: json['number_of_participants'],
          banner: json['banner'],
          daysRemain: json['days_remaining']
        );

  @override
  String toString() {
    return 'DetailEvent{\n'
        '${super.toString()},'
        'startedAt: $startedAt,\n\t '
        'endedAt: $endedAt,\n\t '
        'regulations: $regulations,\n\t '
        'description: $description,\n\t '
        'contactInformation: $contactInformation,\n\t '
        'sportType: $sportType,\n\t '
        'competition: $competition,\n\t '
        'privacy: $privacy,\n\t'
        'participants: $participants\n'
        '}\n';
  }
}

class CreateEvent {
  final String? name;
  final String? description;
  final String? competition;
  final String? sportType;
  final String? contactInformation;
  final String? startedAt;
  final String? endedAt;
  final String? rankingType;
  final String? completionGoal;
  final String? privacy;
  final Map<String, dynamic>? regulations;
  final bool? totalAccumulatedDistance;
  final bool? totalMoneyDonated;

  CreateEvent({
     required this.name,
     required this.description,
     required this.competition,
     required this.sportType,
     required this.contactInformation,
     required this.startedAt,
     required this.endedAt,
     required this.rankingType,
     required this.completionGoal,
     required this.privacy,
     required this.regulations,
     required this.totalAccumulatedDistance,
     required this.totalMoneyDonated,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'competition': competition,
      'sport_type': sportType,
      'contact_information': contactInformation,
      'started_at': startedAt,
      'ended_at': endedAt,
      'ranking_type': rankingType,
      'completion_goal': completionGoal,
      'privacy': privacy,
      'regulations': regulations,
      'total_accumulated_distance': totalAccumulatedDistance,
      'total_money_donated': totalMoneyDonated,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}