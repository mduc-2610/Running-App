class User {
  final String? id;
  final String? email;
  final String? username;
  final String? phoneNumber;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.phoneNumber,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        username = json['username'],
        phoneNumber = json['phone_number'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone_number': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, phoneNumber: $phoneNumber}';
  }
}

class DetailUser extends User {
  final bool isVerifiedEmail;
  final bool isVerifiedPhone;

  DetailUser({
    String? id,
    String? email,
    String? username,
    String? phoneNumber,
    required this.isVerifiedEmail,
    required this.isVerifiedPhone,
  }) : super(
    id: id,
    email: email,
    username: username,
    phoneNumber: phoneNumber,
  );

  DetailUser.fromJson(Map<String, dynamic> json)
      : isVerifiedEmail = json['is_verified_email'],
        isVerifiedPhone = json['is_verified_phone'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['is_verified_email'] = isVerifiedEmail;
    data['is_verified_phone'] = isVerifiedPhone;
    return data;
  }

  @override
  String toString() {
    return 'DetailUser{'
        'id: $id, '
        'email: $email, '
        'username: $username, '
        'phoneNumber: $phoneNumber, '
        'isVerifiedEmail: $isVerifiedEmail, '
        'isVerifiedPhone: $isVerifiedPhone}';
  }
}

class CreateUser {
  final String? id;
  final String? username;
  final String? email;
  final String? password;

  CreateUser({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
