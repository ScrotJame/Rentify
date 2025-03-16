import 'package:http/http.dart' as http;
import 'package:rentify/model/pay/payment.dart';
import 'dart:convert';
import 'package:rentify/model/propertities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/amenities.dart';
import '../model/pay/paymentAccounts.dart';
import '../model/user.dart';
import 'API.dart';
import 'log/log.dart';

class API_implements implements API {
  late Log log;
  final String baseUrl = 'http://192.168.1.15:8000/api';

  API_implements(this.log);

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) throw Exception('No token found');
    return token;
  }
  Future<void> delay() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<Map<String, dynamic>> checkLogin(String username, String password) async {
    log.i1('API_implements', 'Attempting to login with: {username: $username, password: $password}');
    await delay();

    try {
      print('Debug: Sending login request to $baseUrl/login with data: {username: $username, password: $password}');
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"username": username, "password": password}),
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
        return {
          "message": "Login successful",
          "token": token
        };
      } else {
        log.i('API_implements', 'Login failed: ${response.body}');
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ?? "Login failed"
        };
      }
    } catch (e) {
      print('Debug: Exception during login: $e');
      log.i('API_implements', 'Error during login: $e');
      return {
        "success": false,
        "message": "An error occurred: $e"
      };
    }
  }

//lay tat ca cac phong
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
//thong tin chi tiet phong
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
        if (response.body.isEmpty) {
          log.i('API_implements', 'Empty response body for userId: $userId');
          throw Exception('Không tìm thấy bất động sản');
        }

        final decodedData = jsonDecode(response.body);
        if (decodedData == null || decodedData is! Map<String, dynamic>) {
          log.i('API_implements', 'Invalid response format: $decodedData');
          throw Exception('Dữ liệu trả về không hợp lệ');
        }

        final Map<String, dynamic> data = decodedData;
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
//lay thong cac tien ich cu phong
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

//dat phong
  @override
  Future<Map<String, dynamic>> addBooking(int propertyId, String viewingTime) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    // Debug: Kiểm tra token có tồn tại không
    print('Debug: Token retrieved: $token');
    if (token == null) {
      throw Exception('No token available. Please login first.');
    }

    // Debug: In thông tin yêu cầu gửi đi
    print('Debug: Booking property with property_id: $propertyId, viewing_time: $viewingTime');

    final requestBody = {
      'property_id': propertyId,
      'viewing_time': viewingTime,
    };
    print('Debug: Request body: ${jsonEncode(requestBody)}'); // In body để kiểm tra

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Debug: In trạng thái và phản hồi từ server
      print('Debug: Booking response status: ${response.statusCode}');
      print('Debug: Booking response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Debug: Kiểm tra user_id trong phản hồi
        if (responseData.containsKey('data') && responseData['data'].containsKey('user_id')) {
          print('Debug: Booking created for user_id: ${responseData['data']['user_id']}');
        } else {
          print('Debug: user_id not found in response');
        }

        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ?? 'Booking failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception during booking: $e');
      throw Exception('Booking failed: $e');
    }
  }

  @override
  Future<List<ResultProperty>> searchProperties(String keyword, {int page = 1}) async {
    await Future.delayed(const Duration(seconds: 1));
    log.i1('API_implements', 'Fetching properties for keyword: $keyword, page: $page');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        log.i('API_implements', 'No token found.');
        throw Exception('No token found. Please login first.');
      }

      final url = Uri.parse('$baseUrl/search?keyword=$keyword&page=$page');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Debug: Response status: ${response.statusCode}');
      print('Debug: Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          log.i('API_implements', 'Empty response body');
          return [];
        }

        final dynamic decoded = jsonDecode(response.body);
        log.i('API_implements', 'Invalid JSON response a1: $decoded');
        if (decoded == null || decoded is! Map<String, dynamic>) {
          log.i('API_implements', 'Invalid JSON response a: $decoded');
          return [];
        }

        final Map<String, dynamic> jsonResponse = decoded as Map<String, dynamic>;
        print('Debug: Decoded JSON response 1: $jsonResponse');
        final List<dynamic> data = jsonResponse['data'] ?? [];
        return data
            .where((item) => item != null) // Loại bỏ null
            .map((item) {
          print('Debug: Parsing Property JSON 2: $item');
          return ResultProperty.fromJson(item as Map<String, dynamic>);
        })
            .toList();
      } else {
        throw Exception('Failed to search properties: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Debug: Exception in searchProperties: $e');
      log.i('API_implements', 'Error searching properties: $e');
      rethrow;
    }
  }

  @override
  Future<User> getUser() async{
    await delay();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
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
          throw Exception('Không tìm thấy bất động sản');
        }
        print('Debug: Before parsing DetailProperty');
        final user = User.fromJson(data);
        print('Debug: After parsing profile: ${user.toJson()}');
        return user;
      } else {
        throw Exception('Failed to load profile properties: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception in getProperty: $e');
      log.i('API_implements', 'Error fetching profile properties: $e');
      rethrow;
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      final token = await _getToken();
      final url = Uri.parse('$baseUrl/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Xóa token khỏi SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
      } else {
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Logout error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> register(String username,  String password, String email) async {
    print('Debug: Starting register with username: $username, email: $email');

    try {
      // Gửi yêu cầu đăng ký
      print('Debug: Sending register request to $baseUrl/register');
      print('Debug: Request body: ${jsonEncode(
          {'username': username, 'email': email, 'password': password})}');
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
            {'username': username, 'email': email, 'password': password}),
      );

      // Debug response
      print('Debug: Register response status: ${response.statusCode}');
      print('Debug: Register response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Debug: Decoded register data: $data');
        return data;
      } else {
        final errorData = jsonDecode(response.body);
        print('Debug: Register failed with status: ${response
            .statusCode}, error: $errorData');
        throw Exception(
            'Register failed: ${errorData['message'] ?? response.body}');
      }
    } catch (e) {
      // Debug lỗi nếu có exception
      print('Debug: Exception during register: $e');
      throw Exception('Register failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> addPaymentAccount(PaymentAccount paymentAccount) async {
    try {
      // Lấy token từ SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      // Kiểm tra token
      if (token == null) {
        return {
          'success': false,
          'message': 'No authentication token found',
          'errors': {'token': ['Token is missing or invalid']},
        };
      }

      // Log thông tin gửi đi để debug
      log.i('API_implements','Debug: Sending payment account data - $paymentAccount');

      // Gửi yêu cầu POST
      final response = await http.post(
        Uri.parse('$baseUrl/insertpayments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'account_number': paymentAccount.accountNumber,
          'account_name': paymentAccount.accountName,
          'payment_method': paymentAccount.paymentMethod,
          'is_default': paymentAccount.isDefault,
          'expiration_date': paymentAccount.expirationDate, // Thêm trường mới
          'cvv': paymentAccount.cvv, // Thêm trường mới
        }),
      );

      // Log phản hồi từ server để debug
      log.i('API_implements','Debug: Response status code: ${response.statusCode}, Body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'],
          'data': PaymentAccount.fromJson(responseData['data']),
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Unknown error',
          'errors': responseData['errors'] ?? {'general': ['Server error']},
        };
      }
    } catch (e) {
      // Log lỗi chi tiết
      log.i1('API_implements','Debug: Exception in addPaymentAccount: $e');
      log.i('API_implements', 'Error adding payment account: $e');

      // Trả về lỗi đồng nhất
      return {
        'success': false,
        'message': 'An error occurred while adding payment account',
        'errors': {'general': ['Exception: $e']},
      };
    }
  }
  @override
  Future<AllPayment> getAllPayment() async {
    print('Fetching all payment...'); // Thay log.i1 nếu không có thư viện log
    await Future.delayed(Duration(seconds: 1)); // Thay delay() nếu không định nghĩa

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      print('No token found. User must login first.');
      throw Exception('No token found. Please login first.');
    }

    try {
      print('Debug: Sending GET request to $baseUrl/userpayments with token: $token');
      final response = await http.get(
        Uri.parse('$baseUrl/userpayments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Debug: GetAllPayment response status: ${response.statusCode}');
      print('Debug: GetAllPayment response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return AllPayment.fromJson(data);
      } else {
        throw Exception('Failed to load payments: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Debug: Exception in getAllPayment: $e');
      rethrow;
    }
  }

}
