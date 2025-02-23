import 'dart:async';
import 'dart:convert' as Convert;
import 'package:http/http.dart' as http;

class HttpRequest {
  final String baseUrl;

  HttpRequest(this.baseUrl);

  Future<dynamic> get(String uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
          Uri.parse(baseUrl + uri), headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Lỗi kết nối: ${e.toString()}');
    }
  }

  Future<dynamic> post(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
          Uri.parse(baseUrl + uri), body: body, headers: headers);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Lỗi kết nối: ${e.toString()}');
    }
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      try {
        final result = Convert.jsonDecode(body);
        print('[statusCode=$statusCode][response=$result]');
        return result;
      } catch (e) {
        throw Exception('Lỗi parse JSON: ${e.toString()}');
      }
    } else {
      throw Exception('Lỗi HTTP: $statusCode - $body');
    }
  }
}