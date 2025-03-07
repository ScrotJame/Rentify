import 'package:rentify/model/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/model/viewing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/amenities.dart';
import '../model/user.dart';
import '../model/images.dart';
import 'API.dart';
import 'log/log.dart';

class API_implements implements API {
  late Log log;
  final String baseUrl = 'http://192.168.1.5:8000/api';

  API_implements(this.log);

  Future<void> delay() async {
    log.i1('API_implements', 'Delaying for 2 seconds...');
    await Future.delayed(Duration(seconds: 2));
    log.i1('API_implements', 'Delay completed.');
  }

  @override
  Future<bool> checkLogin(Login login) async {
    log.i1('API_implements', 'Attempting to login with: ${login.toJson()}');
    await delay();

    try {
      print('Debug: Sending login request to $baseUrl/login with data: ${login.toJson()}');
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(login.toJson()),
      );

      print('Debug: Login response status: ${response.statusCode}');
      print('Debug: Login response body: ${response.body}');
      log.i1('API_implements', 'Login API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Debug: Decoded login data: $data');
        final token = data['token'];
        print('Debug: Extracted token: $token');

        final prefs = await SharedPreferences.getInstance();
        print('Debug: Saving token to SharedPreferences...');
        await prefs.setString('auth_token', token);
        print('Debug: Token saved: $token');

        log.i1('API_implements', 'Login successful, token saved.');
        return true;
      } else {
        log.i('API_implements', 'Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Debug: Exception during login: $e');
      log.i('API_implements', 'Error during login: $e');
      return false;
    }
  }

  @override
  Future<List<AllProperty>> getAllProperty() async {
    log.i1('API_implements', 'Fetching all properties...');
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      log.i('API_implements', 'No token found. User must login first.');
      throw Exception('No token found. Please login first.');
    }

    try {
      print('Debug: Sending GET request to $baseUrl/allproperties with token: $token');
      final response = await http.get(
        Uri.parse('$baseUrl/allproperties'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Debug: GetAllProperty response status: ${response.statusCode}');
      print('Debug: GetAllProperty response body: ${response.body}');
      log.i1('API_implements', 'GetAllProperty API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded data length: ${data.length}');
        log.i1('API_implements', 'Fetched ${data.length} properties.');
        return data.map((json) {
          print('Debug: Parsing AllProperty JSON: $json');
          return AllProperty.fromJson(json);
        }).toList();
      } else {
        throw Exception('Failed to load properties: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Debug: Exception in getAllProperty: $e');
      log.i('API_implements', 'Error fetching properties: $e');
      rethrow;
    }
  }

  @override
  Future<DetailProperty> getProperty(int userId) async {
    log.i1('API_implements', 'Fetching property details for userId: $userId');
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token for getProperty: $token');

    if (token == null) {
      log.i('API_implements', 'No token found. User must login first.');
      throw Exception('No token found. Please login first.');
    }

    try {
      print('Debug: Sending GET request to $baseUrl/detailproperty/$userId with token: $token');
      final response = await http.get(
        Uri.parse('$baseUrl/detailproperty/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Debug: GetProperty response status: ${response.statusCode}');
      print('Debug: GetProperty response body: ${response.body}');
      log.i1('API_implements', 'GetProperty API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded getProperty data: $data');
        if (data.isEmpty) {
          log.i('API_implements', 'No property data found for userId: $userId');
          throw Exception('Không tìm thấy bất động sản');
        }
        print('Debug: Before parsing DetailProperty');
        final detailProperty = DetailProperty.fromJson(data);
        print('Debug: After parsing DetailProperty: ${detailProperty.toJson()}');
        return detailProperty;
      } else {
        throw Exception('Failed to load user properties: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception in getProperty: $e');
      log.i('API_implements', 'Error fetching user properties: $e');
      rethrow;
    }
  }

  @override
  Future<List<Amenity>> getAmenitiesProperty(int propertyId) async {
    log.i1('API_implements', 'Fetching amenities for propertyId: $propertyId');

    try {
      print('Debug: Sending GET request to $baseUrl/protities/$propertyId/amenities');
      final response = await http.get(Uri.parse('$baseUrl/protities/$propertyId/amenities'));

      print('Debug: GetAmenitiesProperty response status: ${response.statusCode}');
      print('Debug: GetAmenitiesProperty response body: ${response.body}');
      log.i1('API_implements', 'GetAmenitiesProperty API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded amenities data length: ${data.length}');
        return data.map((item) {
          print('Debug: Parsing Amenity JSON: $item');
          return Amenity.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception('Failed to load amenities: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Debug: Exception in getAmenitiesProperty: $e');
      log.i('API_implements', 'Error fetching amenities: $e');
      rethrow;
    }
  }

  @override
  Future<Booking> addBooking(Booking booking) async {
    log.i1('API_implements', 'Adding new booking: ${booking.toJson()}');

    try {
      print('Debug: Sending POST request to $baseUrl/bookings with data: ${booking.toJson()}');
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(booking.toJson()),
      );

      print('Debug: AddBooking response status: ${response.statusCode}');
      print('Debug: AddBooking response body: ${response.body}');
      log.i1('API_implements', 'AddBooking API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body)['data'];
        print('Debug: Decoded booking data: $json');
        return Booking.fromJson(json);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
        print('Debug: AddBooking error: $error');
        throw Exception('Failed to add booking: $error (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('Debug: Exception in addBooking: $e');
      log.i('API_implements', 'Error adding booking: $e');
      rethrow;
    }
  }

  @override
  Future<List<DetailProperty>> searchProperties(String keyword) {
    // TODO: implement searchProperties
    throw UnimplementedError();
  }
}