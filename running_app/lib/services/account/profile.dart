import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/account/profile.dart';
import '../../utils/constants.dart';

class ProfileApiService {

  Future<List<Profile>> fetchProfiles() async{
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/profile'));
     if(response.statusCode == 200) {
       Iterable jsonResponse = json.decode(response.body);
       return jsonResponse.map((profile) => Profile.fromJson(profile)).toList();
     }
     else {
       throw Exception('Failed to load items from API');
     }
  }
}


class DetailProfileApiService {
  Future<DetailProfile> fetchDetailProfile(String profileId) async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/profile/$profileId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DetailProfile.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load user data from API');
    }
  }
}