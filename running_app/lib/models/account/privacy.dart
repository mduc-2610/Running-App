class Privacy {
  final String? id;
  final String? followPrivacy;
  final String? activityPrivacy;
  final String? user;

  Privacy({
    required this.id,
    required this.followPrivacy,
    required this.activityPrivacy,
    required this.user,
  });

  Privacy.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      followPrivacy = json['follow_privacy'],
      activityPrivacy = json['activity_privacy'],
      user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'follow_privacy': followPrivacy,
      'activity_privacy': activityPrivacy,
      'user': user,
    };
  }

  @override
  String toString() {
    return 'Privacy{id: $id, followPrivacy: $followPrivacy, activityPrivacy: $activityPrivacy, user: $user}';
  }
}

class UpdatePrivacy {
  final String? followPrivacy;
  final String? activityPrivacy;

  UpdatePrivacy({
    required this.followPrivacy,
    required this.activityPrivacy,
  });

  UpdatePrivacy.fromJson(Map<String, dynamic> json)
      : followPrivacy = json['follow_privacy'],
        activityPrivacy = json['activity_privacy'];

  Map<String, dynamic> toJson() {
    return {
      'follow_privacy': followPrivacy,
      'activity_privacy': activityPrivacy,
    };
  }

  @override
  String toString() {
    return '${toJson()}';
  }
}