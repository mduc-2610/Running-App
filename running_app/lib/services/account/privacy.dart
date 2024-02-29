import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/account/privacy.dart';
import '../../utils/constants.dart';

class PrivacyAPIService {
  Future<List<Privacy>> fetchPrivacies() async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/privacy'));

    if(response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((privacy) => Privacy.fromJson(privacy)).toList();
    }
    else {
      throw Exception('Failed to load user data from API');
    }
  }
}

class DetailPrivacyAPIService {
  Future<Privacy> fetchDetailPrivacy(String privacyId) async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/privacy/$privacyId'));

    if(response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Privacy.fromJson(jsonResponse);
    }
    else {
      throw Exception('Failed to load user data from API');
    }
  }
}