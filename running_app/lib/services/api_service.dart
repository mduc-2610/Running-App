import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class APIService {
  final String? endpoint;
  final String? fullUrl;
  final String token;

  APIService({this.endpoint, this.fullUrl, required this.token});

  String url({String id = ''}) {
    return '${APIEndpoints.BASE_URL}/$endpoint/${id != '' ? '$id/' : ''}';
  }

  Future<List<dynamic>> fetchList(final modelFromJson, { String queryParams = "" }) async {
    final response = await http.get(
      Uri.parse(url() + queryParams ?? ""),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((instance) => modelFromJson(instance)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> fetchSingle(final modelFromJson, String? id, { String queryParams = "" }) async {
    final url_ = endpoint != null ? url(id: id!) : fullUrl! + queryParams ?? "";
    final response = await http.get(
      Uri.parse(url_),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return modelFromJson(jsonResponse);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> create(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url()),
      headers: _getHeaders(),
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(url(id: id)),
      headers: _getHeaders(),
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print("Successfully updated");
    } else {
      throw Exception(response.statusCode);
    }
  }

  Map<String, String> _getHeaders() {
    // if (token != null) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'TOKEN $token',
      //   };
      // } else {
      //   return {'Content-Type': 'application/json'};
      // }
    };
  }
}

Future<List<dynamic>> callListAPI(
    String endpoint,
    Function modelFromJson,
    String token,
    { String queryParams = "" }
    ) async {
  APIService service = APIService(endpoint: endpoint, token: token);

  final List<dynamic> querySet = await service.fetchList(
      modelFromJson,
      queryParams: queryParams
  );
  return querySet;
}

Future<dynamic> callRetrieveAPI(
    String? endpoint,
    String? id,
    String? fullUrl,
    Function modelFromJson,
    String token,
    { String queryParams = "" }
    ) async {
  APIService service = APIService(
      endpoint: endpoint,
      fullUrl: fullUrl,
      token: token
  );

  final instance = await service.fetchSingle(
      modelFromJson,
      id,
      queryParams: queryParams
  );
  return instance;
}

Future<dynamic> callCreateAPI(
    String endpoint,
    modelToJson,
    String token
    ) async {
  APIService service = APIService(endpoint: endpoint, token: token);
  return await service.create(modelToJson);
}

Future<void> callUpdateAPI(
    String endpoint,
    String id,
    modelToJson,
    String token
    ) async {
  APIService service = APIService(endpoint: endpoint, token: token);
  await service.update(id, modelToJson);
}