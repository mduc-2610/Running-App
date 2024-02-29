class Category {
  final String? name;

  Category({required this.name});

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Category{name: $name}';
  }
}