import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/account/performance.dart';
import '../../utils/constants.dart';

class PerformanceAPIService {
  Future<List<Performance>> fetchPerformances() async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/performance'));

    if(response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((performance) => Performance.fromJson(performance)).toList();
    }
    else {
      throw Exception('Failed to load user data from API');
    }
  }
}

class DetailPerformanceAPIService {
  Future<Performance> fetchDetailPerformance(String performanceId) async {
    final response = await http.get(Uri.parse('${APIEndpoints.BASE_URL}/performance/$performanceId'));

    if(response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return Performance.fromJson(jsonResponse);
    }
    else {
      throw Exception('Failed to load performance data from API');
    }
  }
}