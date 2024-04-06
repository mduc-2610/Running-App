class Leaderboard {
  String? id;
  String? userId;
  String? name;
  String? gender;
  String? totalDuration;
  double? totalDistance;

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
      name = json["name"],
      gender = json["gender"],
      totalDuration = json["total_duration"],
      totalDistance = json["total_distance"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "name": name,
      "gender": gender,
      "total_duration": totalDuration,
      "total_distance": totalDistance
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}