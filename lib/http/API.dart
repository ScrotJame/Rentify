import 'package:rentify/model/login.dart';
import 'package:rentify/model/propertities.dart';
abstract class API{
  Future<bool> checkLogin(Login login);

  Future<List<AllProperty>> getAllProperty();

  Future<DetailProperty> getProperty(int userId);

  Future<List<DetailProperty>> searchProperties(String keyword);



  Future<void> addTransaction(DetailProperty transaction);

  Future<void> editTransaction(DetailProperty transaction);

  Future<void> deleteTransaction(String dateTime);
}