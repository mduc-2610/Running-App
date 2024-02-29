import 'dart:core';

class Profile {
  final String? id;
  late final String? user;

  Profile({
    required this.id,
    required this.user,
  });
  Profile.fromJson(Map<String, dynamic> json):
      id = json['id'],
      user = json['user'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
    };
  }

  @override
  String toString() {
    return 'Profile{id: $id, user: $user}';
  }
}

class DetailProfile extends Profile {
  final String? avatar;
  final String? updatedAt;
  final String? country;
  final String? city;
  final String? gender;
  final String? dateOfBirth;
  final int? height;
  final int? weight;
  final String? shirtSize;
  final String? trouserSize;
  final int? shoeSize;

  DetailProfile({
    String? id,
    String? user,
    required this.avatar,
    required this.updatedAt,
    required this.country,
    required this.city,
    required this.gender,
    required this.dateOfBirth,
    required this.height,
    required this.weight,
    required this.shirtSize,
    required this.trouserSize,
    required this.shoeSize,
  }) : super(
    id: id,
    user: user
  );

  DetailProfile.fromJson(Map<String, dynamic> json):
        avatar = json['avatar'],
        updatedAt = json['updated_at'],
        country = json['country'],
        city = json['city'],
        gender = json['gender'],
        dateOfBirth = json['date_of_birth'],
        height = json['height'],
        weight = json['weight'],
        shirtSize = json['shirt_size'],
        trouserSize = json['trouser_size'],
        shoeSize = json['shoe_size'],
        super(
          id: json['id'],
          user: json['user'],
        );

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['avatar'] = avatar;
    data['updated_at'] = updatedAt;
    data['country'] = country;
    data['city'] = city;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['height'] = height;
    data['weight'] = weight;
    data['shirt_size'] = shirtSize;
    data['trouser_size'] = trouserSize;
    data['shoe_size'] = shoeSize;
    return data;
  }

  @override
  String toString() {
    return '${avatar ?? ''} ${updatedAt ?? ''} ${country ?? ''} '
        '${city ?? ''} ${gender ?? ''} ${dateOfBirth ?? ''} '
        '${height ?? ''} ${weight ?? ''} ${shirtSize ?? ''} ${trouserSize ?? ''} ${shoeSize ?? ''}';
  }
}