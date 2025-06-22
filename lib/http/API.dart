import 'dart:io';

import 'package:rentify/model/amenities.dart';
import 'package:rentify/model/favorite.dart';
import 'package:rentify/model/propertities.dart';

import '../model/pay/payment.dart';
import '../model/pay/paymentAccounts.dart';
import '../model/user.dart';
import '../model/viewing.dart';
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
  Future<List<AllPropertyByOwner>> getAllPropertyByOwner({String status});

  Future<List<ResultProperty>> searchProperties(String keyword, {int? tenant,
    int? totalRooms});

  Future<Map<String, dynamic>> addBooking(int propertyId, String viewingTime,int paymentId, double amount);


  //Payment
  Future<Map<String, dynamic>> addPaymentAccount(PaymentAccount paymentAccount);
  Future<AllPayment> getAllPayment();
  Future<PaymentAccount> getDefaultPaymentAccount();

  //Lease
  Future<List<Viewing>> getLease();
  Future<Viewing> getDetailLease(int id);

  // Favorite
  Future<Map<String, dynamic>> addFavorite(int propertyId);
  Future<List<Favorite>> getFavorites();
  Future<Map<String, dynamic>> deleteFavorite(int propertyId);
  //Host
  Future<Map<String, dynamic>> addProperty(Property property, List<File> imageFiles, List<AllAmenity> amenities);
  Future<List<AllAmenity>> getAmenities();
}