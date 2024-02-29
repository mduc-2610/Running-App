class Brand {
  final String? name;
  final String? logo;

  Brand({required this.name, required this.logo});

  Brand.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        logo = json['logo'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
    };
  }

  @override
  String toString() {
    return 'Brand{name: $name, logo: $logo}';
  }
}