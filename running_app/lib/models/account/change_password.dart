class ChangePassword {
  final String? userId;
  final String? oldPassword;
  final String? newPassword;
  final String? confirmNewPassword;

  ChangePassword({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  ChangePassword.fromJson(Map<String, dynamic> json)
    : userId = json['user_id'],
      oldPassword = json['old_password'],
      newPassword = json['new_password'],
      confirmNewPassword = json['confirm_new_password'];

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'old_password': oldPassword,
      'new_password': newPassword,
      'confirm_new_password': confirmNewPassword,
    };
  }

  @override
  String toString(){
    return '${toJson()}';
  }
}