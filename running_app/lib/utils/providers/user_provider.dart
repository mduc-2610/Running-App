import 'package:flutter/material.dart';
import 'package:running_app/models/account/user.dart';

class UserProvider with ChangeNotifier {
  DetailUser? _user;

  DetailUser? get user => _user;

  void setUser(DetailUser? user) {
    _user = user;
    notifyListeners();
  }
}
