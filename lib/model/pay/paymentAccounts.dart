import 'dart:convert';

class PaymentAccount {
  final String? accountNumber;
  final String accountName;
  final String paymentMethod;
  final String? providerName;
  final String? cardType;
  final String? expirationDate;
  final bool isDefault;
  final String? cvv;
  final int? addressCode;
  final int? userId;

  PaymentAccount({
    this.accountNumber,
    required this.accountName,
    required this.paymentMethod,
    this.providerName,
    this.cardType,
    this.expirationDate,
    required this.isDefault,
    this.cvv,
    this.addressCode,
    this.userId,
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) {
    return PaymentAccount(
      accountNumber: json['account_number'] as String?,
      accountName: json['account_name'] as String? ?? 'Unknown',
      paymentMethod: json['payment_method'] as String? ?? 'unknown',
      providerName: json['provider_name'] as String?,
      cardType: json['card_type'] as String?,
      expirationDate: json['expiration_date'] as String?,
      isDefault: _parseIsDefault(json['is_default']),
      cvv: json['cvv'] as String? ?? 'unknown',
      addressCode: json['address_code'] != null
          ? int.tryParse(json['address_code'].toString())
          : null, // Chuyển đổi an toàn
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
    );
  }

  static bool _parseIsDefault(dynamic value) {
    if (value == null) return false;
    if (value is int) return value == 1;
    if (value is bool) return value;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return false; // Giá trị mặc định nếu không hợp lệ
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'account_name': accountName,
      'payment_method': paymentMethod,
      'provider_name': providerName,
      'card_type': cardType,
      'expiration_date': expirationDate,
      'is_default': isDefault ? 1 : 0,
      'cvv': cvv,
      'address_code': addressCode,
      'user_id': userId,
    };
  }
}