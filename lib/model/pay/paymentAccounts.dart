import 'dart:convert';
class PaymentAccount {
  final String? accountNumber;
  final String accountName;
  final String paymentMethod;
  final String? providerName;
  final String? cardType;
  final String? expirationDate;
  final bool isDefault;
  final int? userId;

  PaymentAccount({
    this.accountNumber,
    required this.accountName,
    required this.paymentMethod,
    this.providerName,
    this.cardType,
    this.expirationDate,
    required this.isDefault,
    this.userId,
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) {
    return PaymentAccount(
      accountNumber: json['account_number'],
      accountName: json['account_name'],
      paymentMethod: json['payment_method'],
      providerName: json['provider_name'],
      cardType: json['card_type'],
      expirationDate: json['expiration_date'],
      isDefault: json['is_default'] == 1 || json['is_default'] == true,
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'account_name': accountName,
      'payment_method': paymentMethod,
      'provider_name': providerName,
      'card_type': cardType,
      'expiration_date': expirationDate,
      'is_default': isDefault,
      'user_id': userId,
    };
  }
}