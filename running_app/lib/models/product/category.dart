class Category {
  final String? id;
  final String? name;

  Category({
    required this.id,
    required this.name
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Category{name: $name}';
  }
}