
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/account/user.dart';
import '../../utils/constants.dart';

class UserApiService {

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/user'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load items from API');
    }
  }
}


class DetailUserApiService {
  Future<DetailUser> fetchDetailUser(String userId) async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/user/$userId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      // return DetailUser.fromJson(jsonResponse);
      return jsonResponse;
    } else {
      throw Exception('Failed to load user data from API');
    }
  }
}