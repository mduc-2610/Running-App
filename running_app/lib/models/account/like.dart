class Like {
  String? id;
  String? name;
  String? avatar;

  Like({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Like.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  @override
  String toString() {
    return "${toJson()}";
  }
}