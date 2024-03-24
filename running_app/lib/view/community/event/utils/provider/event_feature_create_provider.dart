import 'package:flutter/material.dart';

class EventFeatureCreateProvider extends ChangeNotifier {
  String? _competition;
  String? _sportType;

  String? get competition => _competition;
  String? get sportType => _sportType;

  void setData({
    String? competition,
    String? sportType,
  }) {
    _competition = competition;
    _sportType = sportType;
  }

  set competition(String? competition) {
    _competition = competition;
  }

  set sportType(String? sportType) {
    _sportType = sportType;
  }
}