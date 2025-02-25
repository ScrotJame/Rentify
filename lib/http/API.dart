import 'package:rentify/http/http_request.dart';
import 'package:rentify/bean/property.dart'; // Giả sử bạn có class DetailProperty ở đây

class API {
  static const String BASER_URL_API = 'http://127.0.0.1:8000';
  static const String ALL_PROPERTIES_ENDPOINT = '/api/allproperties';
  static const String DETAIL_PROPERTIES_ENDPOINT = '/api/detailproperty/';
  static const String AMENTITIES_DETAIL_ID= 'api/protities/amentities/';
  static const String ALL_AMENITIES= 'api/allamenities';

  static final HttpRequest _httpRequest = HttpRequest(BASER_URL_API);

  static Future<List<DetailProperty>> fetchProperties(int propertyId) async {
    try {
      final response = await _httpRequest.get('$DETAIL_PROPERTIES_ENDPOINT$propertyId');
      // Xử lý dữ liệu trả về
      if (response is List) {
        return response.map((item) => DetailProperty.fromJson(item)).toList();
      } else {
        throw Exception('Dữ liệu trả về không phải là một danh sách');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách bất động sản: ${e.toString()}');
    }
  }
  static Future<List<AllProperty>> fetchAllProperty() async {
    try {
      final response = await _httpRequest.get(ALL_PROPERTIES_ENDPOINT);
      print('fetchAllProperty response: $response'); // Debug dữ liệu trả về

      if (response is List) {
        return response.map((item) => AllProperty.fromJson(item)).toList();
      } else if (response is Map<String, dynamic>){
        List<AllProperty> properties = [];
        for (var key in response.keys) {
          properties.add(AllProperty.fromJson(response[key]));
        }
        return properties;
      }
      else {
        throw Exception('Dữ liệu trả về không đúng định dạng');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách: ${e.toString()}');
    }
  }


  static Future<DetailProperty> fetchAmentitiesProperty(int propertyId) async {

    try {
      final response = await _httpRequest.get('$AMENTITIES_DETAIL_ID$propertyId');
      if (response is Map<String, dynamic>) {
        return DetailProperty.fromJson(response);
      } else {
        throw Exception('Dữ liệu trả về không đúng định dạng');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy chi tiết bất động sản: ${e.toString()}');
    }
  }

  static Future<List<String>> fetchAllAmentities() async {
    try {
      final response = await _httpRequest.get(ALL_AMENITIES);
      if (response is List) {
        // Giả sử API trả về danh sách các tiện nghi dưới dạng List<String>
        return List<String>.from(response);
      } else if (response is Map<String, dynamic>){
        List<String> amenities = [];
        for (var key in response.keys) {
          amenities.add(response[key].toString());
        }
        return amenities;
      }
      else {
        throw Exception('Dữ liệu trả về không đúng định dạng');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy danh sách tiện nghi: ${e.toString()}');
    }
  }

// Thêm các phương thức khác ở đây
}