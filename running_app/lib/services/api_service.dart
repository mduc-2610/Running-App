import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class APIService {
  final String endpoint;

  APIService({required this.endpoint});

  String url({String id = ''}) {
    return '${APIEndpoints.BASE_URL}/$endpoint/${id != '' ? '$id/' : ''}';
  }

  Future<List<dynamic>> fetchList(final modelFromJson) async {
    final response = await http.get(
        Uri.parse(url())
    );

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((instance) => modelFromJson(instance)).toList();
    }
    else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> fetchSingle(final modelFromJson, String id) async {
    final response = await http.get(
        Uri.parse(url(id: id))
    );

    if(response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return modelFromJson(jsonResponse);
    }
    else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> create(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url()),
      headers: <String, String> {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if(response.statusCode == 201) {
      return json.decode(response.body);
    }
    else {
      // print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(url(id: id)),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );

    if(response.statusCode == 200) {
      print("Successfully updated");
    }
    else {
      throw Exception(response.statusCode);
    }
  }
}


Future<List<dynamic>> callListAPI(
    String endpoint,
    Function modelFromJson
    ) async {
  APIService service = APIService(endpoint: endpoint);

  final List<dynamic> querySet = await service.fetchList(modelFromJson);
  return querySet;
}

Future<dynamic> callRetrieveAPI(
    String endpoint,
    String id,
    Function modelFromJson
    ) async {
  APIService service = APIService(endpoint: endpoint);

  final instance = await service.fetchSingle(modelFromJson, id);
  return instance;
}

Future<dynamic> callCreateAPI(
    String endpoint,
    modelToJson
    ) async {
  APIService service = APIService(endpoint: endpoint);
  return await service.create(modelToJson);
}

Future<void> callUpdateAPI(
    String endpoint,
    String id,
    modelToJson,
    ) async {
  APIService service = APIService(endpoint: endpoint);
  await service.update(id, modelToJson);
}