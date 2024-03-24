import 'package:flutter/material.dart';

class EventAdvancedOptionCreateProvider extends ChangeNotifier {
  String? _privacy;
  Map<String, dynamic>? _regulations;
  bool? _totalAccumulatedDistance;
  bool? _totalMoneyDonated;
  double? _donatedMoneyExchange;

  void setData({
    String? privacy,
    Map<String, dynamic>? regulations,
    bool? totalAccumulatedDistance,
    bool? totalMoneyDonated,
    double? donatedMoneyExchange,
  }) {
    _privacy = privacy;
    _regulations = regulations;
    _totalAccumulatedDistance = totalAccumulatedDistance;
    _totalMoneyDonated = totalMoneyDonated;
    _donatedMoneyExchange = donatedMoneyExchange;
    notifyListeners();
  }

  String? get privacy => _privacy;
  Map<String, dynamic>? get regulations => _regulations;
  bool? get totalAccumulatedDistance => _totalAccumulatedDistance;
  bool? get totalMoneyDonated => _totalMoneyDonated;
  double? get donatedMoneyExchange => _donatedMoneyExchange;

  set privacy(String? value) {
    _privacy = value;
    notifyListeners();
  }

  set regulations(Map<String, dynamic>? value) {
    _regulations = value;
    notifyListeners();
  }

  set totalAccumulatedDistance(bool? value) {
    _totalAccumulatedDistance = value;
    notifyListeners();
  }

  set totalMoneyDonated(bool? value) {
    _totalMoneyDonated = value;
    notifyListeners();
  }

  set donatedMoneyExchange(double? value) {
    _donatedMoneyExchange = value;
    notifyListeners();
  }
}
