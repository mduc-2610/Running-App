class Login {
  final String? username;
  final String? password;

  Login({
    required this.username,
    required this.password,
  });

  Login.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  String toString(){
    return '${toJson()}';
  }
}