import 'package:flutter/material.dart';

class DeleteActivityStateProvider extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  set state(bool state) {
    _state = state;
    notifyListeners();
  }
}