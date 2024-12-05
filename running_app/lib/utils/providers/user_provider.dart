
import 'package:flutter/material.dart';
import 'package:running_app/models/account/activity.dart';
import 'package:running_app/models/account/performance.dart';
import 'package:running_app/models/account/privacy.dart';
import 'package:running_app/models/account/profile.dart';
import 'package:running_app/models/account/user.dart';
import 'package:running_app/services/api_service.dart';

class UserProvider with ChangeNotifier {
  late DetailUser? _user;
  late Activity? _userActivity;
  late Profile? _userProfile;
  late Privacy? _userPrivacy;
  late Performance? _userPerformance;

  DetailUser? get user => _user;
  Activity? get userActivity => _userActivity;
  Profile? get userProfile => _userProfile;
  Privacy? get userPrivacy => _userPrivacy;
  Performance? get userPerformance => _userPerformance;

  set userActivity(Activity? activity) {
    _userActivity = activity;
    notifyListeners();
  }

  set userProfile(Profile? profile) {
    _userProfile = profile;
    notifyListeners();
  }

  set userPrivacy(Privacy? privacy) {
    _userPrivacy = privacy;
    notifyListeners();
  }

  set userPerformance(Performance? performance) {
    _userPerformance = performance;
    notifyListeners();
  }

  set userName(String name) {
    _user?.name = name;
    notifyListeners();
  }

  void setUser(
      DetailUser? user,
      {
        Activity? userActivity,
        Profile? userProfile,
        Privacy? userPrivacy,
        Performance? userPerformance
      }) async {
    _user = user;
    // notifyListeners();
    // _userActivity = userActivity;
    // notifyListeners();
    // _userProfile = userProfile;
    // notifyListeners();
    // _userPrivacy = userPrivacy;
    // notifyListeners();
    // _userPerformance = userPerformance;
    // notifyListeners();
  }
  void resetUser() {
    _user = null;
    notifyListeners();
  }

  //
  // Future<Activity> initUserActivity(String token) async {
  //   return await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
  // }
  //
  // Future<Profile> initUserProfile(String token) async {
  //   return await callRetrieveAPI(null, null, user?.profile, DetailProfile.fromJson, token);
  // }
  //
  // Future<Privacy> initUserPrivacy(String token) async {
  //   return await callRetrieveAPI(null, null, user?.privacy, Privacy.fromJson, token);
  // }
  //
  // Future<Performance> initUserPerformance(String token) async {
  //   return await callRetrieveAPI(null, null, user?.performance, Performance.fromJson, token);
  // }
  // void setUserSide({Activity? userActivity, Profile? userProfile, Privacy? userPrivacy, Performance? userPerformance}) async {
  //   _userActivity = userActivity;
  //   _userProfile = userProfile;
  //   _userPrivacy = userPrivacy;
  //   _userPerformance = userPerformance;
  //   notifyListeners();
  // }
}
