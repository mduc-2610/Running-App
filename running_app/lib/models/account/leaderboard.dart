class Leaderboard {
  String? id;
  String? userId;
  String? actId;
  String? name;
  String? avatar;
  String? gender;
  String? totalDuration;
  double? totalDistance;
  String? checkUserFollow;
  // Leaderboard({
  //   required this.id,
  //   required this.userId,
  //   required this.name,
  //   required this.gender,
  //   required this.totalDuration,
  //   required this.totalDistance,
  // });

  Leaderboard.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      userId = json["user_id"],
      actId = json["act_id"],
      name = json["name"],
      avatar = json["avatar"],
      gender = json["gender"],
      totalDuration = json["total_duration"],
      totalDistance = json["total_distance"],
      checkUserFollow = json["check_user_follow"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "act_id": actId,
      "name": name,
      "gender": gender,
      "total_duration": totalDuration,
      "total_distance": totalDistance,
      "check_user_follow": checkUserFollow
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}