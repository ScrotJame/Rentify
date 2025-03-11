import 'package:rentify/model/amenities.dart';
import 'package:rentify/model/login.dart';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/model/viewing.dart';

import '../model/user.dart';
abstract class API{
  Future<Map<String, dynamic>> checkLogin(String username, String password);

  Future<Map<String, dynamic>> register(String username,  String password, String email);

  Future<List<AllProperty>> getAllProperty();

  Future<DetailProperty> getProperty(int userId);

  Future<List<Amenity>> getAmenitiesProperty(int userId);

  Future<List<ResultProperty>> searchProperties(String keyword);

  Future<Booking> addBooking(Booking booking);

  Future<User> getUser();

  Future <void> logoutUser();
}