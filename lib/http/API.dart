import 'package:rentify/model/login.dart';
import 'package:rentify/model/propertities.dart';
abstract class API{
  Future<bool> checkLogin(Login login);

  Future<double> getTotal();

  Future<List<String>> getMonths();

  Future<List<DetailProperty>> getTransactions(String month);

  Future<void> addTransaction(DetailProperty transaction);

  Future<void> editTransaction(DetailProperty transaction);

  Future<void> deleteTransaction(String dateTime);
}