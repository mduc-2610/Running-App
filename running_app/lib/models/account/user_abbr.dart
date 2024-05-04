class UserAbbr {
  final String? id;
  final String? actId;
  final String? name;
  final String? avatar;
  String? checkUserFollow;

  UserAbbr({
    required this.id,
    this.actId,
    required this.name,
    required this.avatar,
    this.checkUserFollow,
  });

  UserAbbr.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        actId = json['act_id'],
        name = json['name'],
        avatar = json['avatar'],
        checkUserFollow = json['check_user_follow'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'act_id': actId,
      'name': name,
      'avatar': avatar,
      'check_user_follow': checkUserFollow
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}