import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = 'dummyjson.com';

  static Future<http.Response> get(String path,
      [Map<String, dynamic>? queryParameters]) async {
    final url = Uri.https(baseUrl, path, queryParameters);
    final response = await http.get(url);
    return response;
  }
}