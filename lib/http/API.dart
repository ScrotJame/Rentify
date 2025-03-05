import 'package:rentify/model/amenities.dart';
import 'package:rentify/model/login.dart';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/model/viewing.dart';
abstract class API{
  Future<bool> checkLogin(Login login);

  Future<List<AllProperty>> getAllProperty();

  Future<DetailProperty> getProperty(int userId);

  Future<List<Amenity>> getAmenitiesProperty(int userId);

  Future<List<DetailProperty>> searchProperties(String keyword);

  Future<Booking> addBooking(Booking booking);



  Future<void> addTransaction(DetailProperty transaction);

  Future<void> editTransaction(DetailProperty transaction);

  Future<void> deleteTransaction(String dateTime);
}