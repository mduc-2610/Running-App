
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

  Future<Activity> initUserActivity(String token) async {
    return await callRetrieveAPI(null, null, user?.activity, Activity.fromJson, token);
  }

  Future<Profile> initUserProfile(String token) async {
    return await callRetrieveAPI(null, null, user?.profile, DetailProfile.fromJson, token);
  }

  Future<Privacy> initUserPrivacy(String token) async {
    return await callRetrieveAPI(null, null, user?.privacy, Privacy.fromJson, token);
  }

  Future<Performance> initUserPerformance(String token) async {
    return await callRetrieveAPI(null, null, user?.performance, Performance.fromJson, token);
  }

  void setUser(DetailUser? user, { String token = ""}) async {
    _user = user;
    // if(token != "") {
    //   await setUserSide(token);
    // }
    notifyListeners();
  }

  // Future<void> setUserSide(String token) async {
  //   _userActivity = await initUserActivity(token);
  //   _userProfile = await initUserProfile(token);
  //   _userPrivacy = await initUserPrivacy(token);
  //   _userPerformance = await initUserPerformance(token);
  //   print(_userActivity);
  // }
}
