import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentify/model/pay/payment.dart';
import 'dart:convert';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/model/viewing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../model/amenities.dart';
import '../model/favorite.dart';
import '../model/images.dart';
import '../model/pay/paymentAccounts.dart';
import '../model/user.dart';
import 'API.dart';
import 'log/log.dart';

class API_implements implements API {
  late Log log;
  final String baseUrl = 'http://192.168.2.29:8000/api';

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
  Future<Map<String, dynamic>> checkLogin(String username,
      String password) async {
    await delay();

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"username": username, "password": password}),
      );
      log.i('API_Login',
          'Login API Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return {
          "message": "Login successful",
          "token": token
        };
      } else {
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ?? "Login failed"
        };
      }
    } catch (e) {
      print('Debug: Exception during login: $e');
      return {
        "success": false,
        "message": "An error occurred: $e"
      };
    }
  }

//lay tat ca cac phong
  @override
  Future<List<AllProperty>> getAllProperty() async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/allproperties'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) {
          return AllProperty.fromJson(json);
        }).toList();
      } else {
        throw Exception(
            'Failed to load properties: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      log.i('API_AllProperty', 'Error fetching properties: $e');
      rethrow;
    }
  }

//thong tin chi tiet phong
  @override
  Future<DetailProperty> getProperty(int userId) async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      print(
          'Debug: Sending GET request to $baseUrl/detailproperty/$userId with token: $token');
      final response = await http.get(
        Uri.parse('$baseUrl/detailproperty/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      log.i1('API_implements',
          'GetProperty API Response: ${response.statusCode} - ${response
              .body}');

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
        if (data.isEmpty) {
          throw Exception('Không tìm thấy bất động sản');
        }
        final detailProperty = DetailProperty.fromJson(data);
        return detailProperty;
      } else {
        throw Exception(
            'Failed to load user properties: ${response.statusCode}');
      }
    } catch (e) {
      log.i('API_implements', 'Error fetching user properties: $e');
      rethrow;
    }
  }

//lay thong cac tien ich cu phong
  @override
  Future<List<Amenity>> getAmenitiesProperty(int propertyId) async {
    log.i1('API_implements', 'Fetching amenities for propertyId: $propertyId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    try {
      print(
          'Debug: Sending GET request to $baseUrl/protities/$propertyId/amenities');
      final response = await http.get(
        Uri.parse('$baseUrl/protities/$propertyId/amenities'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },);

      print('Debug: GetAmenitiesProperty response status: ${response
          .statusCode}');
      print('Debug: GetAmenitiesProperty response body: ${response.body}');
      log.i1('API_implements', 'GetAmenitiesProperty API Response: ${response
          .statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded amenities data length: ${data.length}');
        return data.map((item) {
          print('Debug: Parsing Amenity JSON: $item');
          return Amenity.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception(
            'Failed to load amenities: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      print('Debug: Exception in getAmenitiesProperty: $e');
      log.i('API_implements', 'Error fetching amenities: $e');
      rethrow;
    }
  }

//dat phong
  @override
  Future<Map<String, dynamic>> addBooking(int propertyId, String viewingTime,
      int paymentId, double amount) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception('No token available. Please login first.');
    }

    // Debug: In thông tin yêu cầu gửi đi
    print(
        'Debug: Booking property with property_id: $propertyId, viewing_time: $viewingTime');

    final requestBody = {
      'property_id': propertyId,
      'viewing_time': viewingTime,
      'payment_id': paymentId,
      'amount': amount,
    };
    print('Debug: Request body: ${jsonEncode(
        requestBody)}'); // In body để kiểm tra

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
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('user_id')) {
          print(
              'Debug: Booking created for user_id: ${responseData['data']['user_id']}');
        } else {
          print('Debug: user_id not found in response');
        }

        return responseData;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error'] ??
            'Booking failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception during booking: $e');
      throw Exception('Booking failed: $e');
    }
  }

//tim kiem
  @override
  Future<List<ResultProperty>> searchProperties(String keyword,
      {
        int page = 1,
        int? tenant,
        int? totalRooms,
      }) async {
    await Future.delayed(const Duration(seconds: 1));
    log.i1('API_implements',
        'Fetching properties for keyword: $keyword, page: $page');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('No token found. Please login first.');
      }

      final queryParameters = {
        'keyword': keyword,
        'page': page.toString(),
        if (tenant != null) 'bedrooms': tenant.toString(),
        if (totalRooms != null) 'bathrooms': totalRooms.toString(),
      };
      final url = Uri.parse('$baseUrl/search').replace(queryParameters: queryParameters);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return [];
        }

        final dynamic decoded = jsonDecode(response.body);
        if (decoded == null || decoded is! Map<String, dynamic>) {
          return [];
        }

        final Map<String, dynamic> jsonResponse = decoded;
        final List<dynamic> data = jsonResponse['data'] ?? [];
        return data
            .where((item) => item != null)
            .map((item) => ResultProperty.fromJson(item as Map<String, dynamic>))
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

//lay thong tin nguoi dung
  @override
  Future<User> getUser() async {
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
      log.i1('API_implements',
          'GetProperty API Response: ${response.statusCode} - ${response
              .body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded get User data: $data');
        if (data.isEmpty) {
          throw Exception('Không tìm thấy bất động sản');
        }
        print('Debug: Before parsing DetailProperty');
        final user = User.fromJson(data);
        print('Debug: After parsing profile: ${user.toJson()}');
        return user;
      } else {
        throw Exception(
            'Failed to load profile properties: ${response.statusCode}');
      }
    } catch (e) {
      print('Debug: Exception in getProperty: $e');
      log.i('API_implements', 'Error fetching profile properties: $e');
      rethrow;
    }
  }

//dang xuat
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

//dang ky
  @override
  Future<Map<String, dynamic>> register(String username, String password,
      String email) async {
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

//add payment account
  @override
  Future<Map<String, dynamic>> addPaymentAccount( PaymentAccount paymentAccount) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        return {
          'success': false,
          'message': 'No authentication token found',
          'errors': {'token': ['Token is missing or invalid']},
        };
      }

      // Log thông tin gửi đi để debug
      log.i('API_addPayment',
          'Debug: Sending payment account data - $paymentAccount');

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
          'expiration_date': paymentAccount.expirationDate,
          'cvv': paymentAccount.cvv,
        }),
      );

      // Log phản hồi từ server để debug
      log.i('API_implements',
          'Debug: Response status code: ${response.statusCode}, Body: ${response
              .body}');

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
      log.i1('API_err_', 'Debug: Exception in addPaymentAccount: $e');
      log.i('API_implements', 'Error adding payment account: $e');

      // Trả về lỗi đồng nhất
      return {
        'success': false,
        'message': 'An error occurred while adding payment account',
        'errors': {'general': ['Exception: $e']},
      };
    }
  }

//get all payment
  @override
  Future<AllPayment> getAllPayment() async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      print(
          'Debug: Sending GET request to $baseUrl/userpayments with token: $token');
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
        throw Exception(
            'Failed to load payments: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      print('Debug: Exception in getAllPayment: $e');
      rethrow;
    }
  }

//get default payment
  @override
  Future<PaymentAccount> getDefaultPaymentAccount() async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      print(
          'Debug: Sending GET request to $baseUrl/defaultaccount with token: $token');
      final response = await http.get(
        Uri.parse('$baseUrl/defaultaccount'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return PaymentAccount.fromJson(data['data']);
      } else {
        throw Exception(
            'Failed to load payments: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      print('Debug: Exception in getAllPayment: $e');
      rethrow;
    }
  }

  @override
  Future<Viewing> getDetailLease(int id) async {
    // TODO: implement getDetailLease
    throw UnimplementedError();
  }

  @override
  Future<List<Viewing>> getLease() async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/viewings'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (!jsonResponse.containsKey('data') || jsonResponse['data'] == null) {
          return [];
        }

        final List<dynamic> data = jsonResponse['data'];

        if (data.isEmpty) {
          print('Debug: No bookings found');
          return [];
        }

        return data.map((json) => Viewing.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load properties: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      print('API Error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> addFavorite(int propertyId) async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        return {
          'success': false,
          'message': 'No authentication token found',
          'errors': {'token': ['Token is missing or invalid']},
        };
      }

      log.i('API_addFavorite',
          'Debug: Sending favorite data - property_id: $propertyId');

      final response = await http.post(
        Uri.parse('$baseUrl/user/addfavorites'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'property_id': propertyId,
        }),
      );

      // Log phản hồi từ server để debug
      log.i('API_implements',
          'Debug: Response status code: ${response.statusCode}, Body: ${response
              .body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseData['message'],
          'data': {
            'user_id': responseData['data']['user_id'],
            'property_id': responseData['data']['property_id'],
            'created_at': responseData['data']['created_at'],
            'updated_at': responseData['data']['updated_at'],
          },
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? responseData['error'] ??
              'Unknown error',
          'errors': responseData['errors'] ?? {'general': ['Server error']},
        };
      }
    } catch (e) {
      log.i1('API_err_', 'Debug: Exception in addToFavorite: $e');
      log.i('API_implements', 'Error adding to favorite: $e');

      return {
        'success': false,
        'message': 'An error occurred while adding to favorite',
        'errors': {'general': ['Exception: $e']},
      };
    }
  }

  @override
  Future<Map<String, dynamic>> deleteFavorite(int propertyId) async{
    await Future.delayed(Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/favorites/delete/$propertyId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body:jsonEncode({
          'property_id': propertyId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load properties: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching properties: $e');
      rethrow;
    }
  }

  @override
  Future<List<Favorite>> getFavorites() async{
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/favorites'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('API Favorite Response: $jsonResponse');

        final message = jsonResponse['message'] ?? 'Success';
        final List<dynamic> data = jsonResponse['data'] ?? [];
        final properties = data.map((json) => AllProperty.fromJson(json)).toList();

        // Bọc vào Favorite để khớp model
        return [
          Favorite(
            message: message,
            data: properties,
          )
        ];
      } else {
        throw Exception('Failed to load properties: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching properties: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> addProperty(Property property,List<File> imageFiles, List<AllAmenity> amenities)  async{
    await delay();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return {
        'success': false,
        'message': 'No authentication token found',
        'errors': {'token': ['Token is missing or invalid']},
      };
    }

    try {
      // Tạo multipart request để upload files
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/insert/properties'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['title'] = property.title;
      request.fields['description'] = property.description;
      request.fields['location'] = property.location;
      request.fields['price'] = property.price.toString();
      request.fields['bedrooms'] = property.bedrooms.toString();
      request.fields['bathrooms'] = property.bathrooms.toString();
      request.fields['area'] = property.area.toString();
      request.fields['deposit'] = property.deposit.toString();
      request.fields['type_restroom'] = property.typeRestroom;
      request.fields['property_type'] = property.propertyType;

      // Thêm amenities dưới dạng mảng (sử dụng ID của Amenity)
      for (int i = 0; i < amenities.length; i++) {
        request.fields['amenities[$i]'] = amenities[i].id.toString();
      }

      // Thêm files ảnh
      for (int i = 0; i < imageFiles.length; i++) {
        final file = imageFiles[i];
        final fileName = file.path.split('/').last;
        final fileExtension = fileName.split('.').last.toLowerCase();

        // Xác định MIME type dựa trên phần mở rộng file
        String mimeType;
        if (fileExtension == 'jpg' || fileExtension == 'jpeg') {
          mimeType = 'image/jpeg';
        } else if (fileExtension == 'png') {
          mimeType = 'image/png';
        } else {
          mimeType = 'application/octet-stream';
        }

        // Thêm file vào request
        request.files.add(await http.MultipartFile.fromPath(
          'image[$i]',
          file.path,
          contentType: MediaType.parse(mimeType),
        ));
      }

      // Gửi request và nhận response
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        // Code 201 cho Created
        final responseData = json.decode(response.body);

        // Parse dữ liệu trả về để tạo đối tượng Image từ response
        if (responseData['data'] != null && responseData['data']['image'] != null) {
          List<dynamic> imageData = responseData['data']['image'];
          List<Image> images = imageData.map((img) => Image.fromJson(img)).toList();
          responseData['data']['parsed_images'] = images;
        }

        return responseData;
      } else {
        throw Exception('Failed to create property: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error creating property: $e');
      return {
        'success': false,
        'message': 'Failed to create property: $e',
      };
    }
  }

  @override
  Future<List<AllAmenity>> getAmenities() async {
    await delay();

    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('auth_token');
    // print('Debug: Retrieved token from SharedPreferences: $token');
    //
    // if (token == null) {
    //   throw Exception('No token found. Please login first.');
    // }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/amentities'),
        // headers: {
        //   'Authorization': 'Bearer $token',
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        // },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Debug: Decoded amenities data length: ${data.length}');
        return data.map((item) {
          print('Debug: Parsing Amenity JSON: $item');
          return AllAmenity.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception(
            'Failed to load properties: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      log.i('API_AllProperty', 'Error fetching properties: $e');
      rethrow;
    }
  }

  @override
  Future<List<AllPropertyByOwner>> getAllPropertyByOwner() async {
    await delay();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug: Retrieved token from SharedPreferences: $token');

    if (token == null) {
      throw Exception('No token found. Please login first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/properties/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) {
          return AllPropertyByOwner.fromJson(json);
        }).toList();
      } else {
        throw Exception(
            'Failed to load properties: ${response.statusCode} - ${response
                .body}');
      }
    } catch (e) {
      log.i('API_AllProperty', 'Error fetching properties: $e');
      rethrow;
    }
  }
}
