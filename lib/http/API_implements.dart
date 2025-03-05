import 'package:rentify/model/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/model/viewing.dart';
import '../model/amenities.dart';
import '../model/pivot.dart';
import '../model/user.dart';
import '../model/images.dart';
import 'API.dart';
import 'log/log.dart';

class API_implements implements API{
  late Log log;
  final String baseUrl='http://192.168.1.23:8000/api';
  API_implements(this.log);

  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  Future<void> addTransaction(DetailProperty transaction) {
    delay();
    throw UnimplementedError();
  }

  @override
  Future<bool> checkLogin(Login login) {
    delay();
    if (login.username== '1' && login.password == '1'){
      return Future.value(true);
    }else{
      return Future.value(false);
    }
  }

  @override
  Future<void> deleteTransaction(String dateTime) {
    delay();
    throw UnimplementedError();
  }

  @override
  Future<void> editTransaction(DetailProperty transaction) {
    delay();
    throw UnimplementedError();
  }

  @override
  Future<List<AllProperty>> getAllProperty() async {
    delay();
    try {
      final response = await http.get(Uri.parse('$baseUrl/allproperties'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => AllProperty.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load properties: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      log.i1('API_implements', 'Error fetching properties: $e');
      rethrow;
    }
  }

  @override
  Future<DetailProperty> getProperty(int userId) async {
    delay();
    try {
      final response = await http.get(Uri.parse('$baseUrl/detailproperty/$userId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data == null || data.isEmpty) {
          throw Exception('Không tìm thấy bất động sản');
        }
        return DetailProperty.fromJson(data);
      } else {
        throw Exception('Failed to load user properties: ${response.statusCode}');
      }
    } catch (e) {
      log.i1('API_implements', 'Error fetching user properties: $e');
      rethrow;
    }

  }

  @override
  Future<List<DetailProperty>> searchProperties(String keyword) async {
    delay();
    final allProperties = await getPropertys(1); // Lấy tất cả dữ liệu mock
    final keywordLower = keyword.toLowerCase().trim();
    return allProperties.where((property) {
      return property.title.toLowerCase().contains(keywordLower) ||
          property.description.toLowerCase().contains(keywordLower) ||
          property.location.toLowerCase().contains(keywordLower) ||
          property.propertyType.toLowerCase().contains(keywordLower) ||
          property.amenities.any((amenity) => amenity.nameAmenities.toLowerCase().contains(keywordLower));
    }).toList();
  }

  @override
  Future<List<DetailProperty>> getPropertys(int userId) {
    // TODO: implement getPropertys
    throw UnimplementedError();
  }

  @override
  Future<List<Amenity>> getAmenitiesProperty(int propertyId) async {
    final response = await http.get(Uri.parse('$baseUrl/protities/$propertyId/amenities'));
    try{
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body); // List<dynamic>
      return data.map((item) => Amenity.fromJson(item as Map<String, dynamic>)).toList();
      }  else {
      throw Exception('Failed to load properties: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
  log.i1('API_implements', 'Error fetching properties: $e');
  rethrow;
  }
  }



  @override
  Future<Booking> addBooking(Booking booking) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(booking.toJson()), // Chuyển Booking thành JSON
      );

      if (response.statusCode == 201) {
        // Phản hồi thành công, trả về Booking từ API
        final json = jsonDecode(response.body)['data'];
        return Booking.fromJson(json);
      } else {
        // Xử lý lỗi từ API
        final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
        throw Exception('Failed to add booking: $error (Status: ${response.statusCode})');
      }
    } catch (e) {
      // Ghi log và ném lại lỗi
      log.i1('API_implements', 'Error adding booking: $e');
      rethrow;
    }
  }

}