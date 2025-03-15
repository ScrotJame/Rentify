import 'package:rentify/model/amenities.dart';
import 'package:rentify/model/propertities.dart';

import '../model/pay/payment.dart';
import '../model/pay/paymentAccounts.dart';
import '../model/user.dart';
abstract class API{
  //Account
  Future<Map<String, dynamic>> checkLogin(String username, String password);
  Future<Map<String, dynamic>> register(String username,  String password, String email);
  Future<User> getUser();
  Future <void> logoutUser();
  //property
  Future<List<AllProperty>> getAllProperty();
  Future<DetailProperty> getProperty(int userId);
  Future<List<Amenity>> getAmenitiesProperty(int userId);

  Future<List<ResultProperty>> searchProperties(String keyword);

  Future<Map<String, dynamic>> addBooking(int propertyId, String viewingTime);


  //Payment
  Future<Map<String, dynamic>> addPaymentAccount(PaymentAccount paymentAccount);
  Future<AllPayment> getAllPayment();


}