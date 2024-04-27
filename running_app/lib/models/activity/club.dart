import 'package:running_app/models/account/leaderboard.dart';

import 'package:running_app/models/account/leaderboard.dart';
import 'package:running_app/models/social/post.dart';

import '../account/user.dart';

class Club {
  final String? id;
  final String? name;
  final String? avatar;
  final String? sportType;
  final int? weekActivities;
  final int? numberOfParticipants;
  final String? privacy;
  final String? organization;
  final int? totalPosts;
  Club({
     required this.id,
     required this.name,
     required this.avatar,
     required this.sportType,
     required this.weekActivities,
     required this.numberOfParticipants,
     required this.privacy,
     required this.organization,
     required this.totalPosts,
  });

  Club.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      avatar = json['avatar'],
      sportType = json['sport_type'],
      weekActivities = json['week_activities'],
      numberOfParticipants = json['number_of_participants'],
      privacy = json['privacy'],
      organization = json['organization'],
      totalPosts = json['total_posts'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'sport_type': sportType,
      'week_activities': weekActivities,
      'number_of_participants': numberOfParticipants,
      'privacy' : privacy,
      'organization' : organization,
      'total_posts': totalPosts,
    };
  }

  @override
  String toString() {
    return 'Club{id: $id, name: $name, avatar: $avatar, sportType: $sportType, weekActivities: $weekActivities, numberOfParticipants: $numberOfParticipants}';
  }
}

class DetailClub extends Club {
  final List<Leaderboard>? participants;
  final String? description;
  final String? coverPhoto;
  final List<ClubPost>? posts;

  DetailClub({
    String? id,
    String? name,
    String? avatar,
    String? sportType,
    String? privacy,
    String? organization,
    int? weekActivities,
    int? numberOfParticipants,
    int? totalPosts,
    required this.posts,
    required this.participants,
    required this.description,
    required this.coverPhoto,
  }) : super(
    id: id,
    name: name,
    avatar: avatar,
    sportType: sportType,
    weekActivities: weekActivities,
    numberOfParticipants: numberOfParticipants,
    privacy: privacy,
    organization: organization,
    totalPosts: totalPosts
  );

  DetailClub.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        participants = (json['participants'] as List<dynamic>?)?.map((e) => Leaderboard.fromJson(e)).toList(),
        coverPhoto = json['cover_photo'],
        posts = (json['posts'] as List<dynamic>).map((e) => ClubPost.fromJson(e)).toList(),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['participants'] = participants?.map((e) => e.toJson());
    data['description'] = description;
    data['cover_photo'] = coverPhoto;
    return data;
  }

  @override
  String toString() {
    return 'DetailClub{${super.toString()}, participants: $participants, description: $description, privacy: $privacy, organization: $organization}';
  }
}

class CreateClub {
  final String? name;
  final String? description;
  final String? avatar;
  final String? cover_photo;
  final String? sportType;
  final String? organization;
  final String? privacy;
  final String? userId;

  CreateClub({
    required this.name,
    required this.description,
    this.avatar,
    this.cover_photo,
    required this.sportType,
    required this.organization,
    required this.privacy,
    required this.userId,
  });

  CreateClub.fromJson(Map<String, dynamic> json) :
      name= json['name'],
      description= json['description'],
      avatar= json['avatar'],
      cover_photo= json['cover_photo'],
      sportType= json['sport_type'],
      organization= json['organization'],
      privacy= json['privacy'],
      userId= json['user_id'];


  @override
  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar,
      'cover_photo': cover_photo,
      'name': name,
      'description': description,
      'sport_type': sportType,
      'organization': organization,
      'privacy': privacy,
    };
  }

  @override
  String toString() {
    return 'CreateClub:${toJson()}';
  }
}