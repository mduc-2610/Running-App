class Author {
  String? id;
  String? name;
  String? avatar;

  Author({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Author.fromJson(Map<String, dynamic> json)
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