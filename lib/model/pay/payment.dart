import 'package:rentify/model/pay/paymentAccounts.dart';
class AllPayment {
  String message;
  List<PaymentAccount> data;

  AllPayment({
    required this.message,
    required this.data,
  });

  factory AllPayment.fromJson(Map<String, dynamic> json) => AllPayment(
    message: json["message"],
    data: List<PaymentAccount>.from(json["data"].map((x) => PaymentAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}