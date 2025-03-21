class PaymentAccount {
  int? id;
  int? userId;
  String accountNumber;
  String accountName;
  String paymentMethod;
  dynamic providerName;
  dynamic cardType;
  DateTime? expirationDate;
  dynamic cvv;
  dynamic addressCode;
  bool isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentAccount({
    this.id,
    this.userId,
    required this.accountNumber,
    required this.accountName,
    required this.paymentMethod,
    this.providerName,
    this.cardType,
    this.expirationDate,
    this.cvv,
    this.addressCode,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) => PaymentAccount(
    id: json["id"],
    userId: json["user_id"],
    accountNumber: json["account_number"],
    accountName: json["account_name"],
    paymentMethod: json["payment_method"],
    providerName: json["provider_name"],
    cardType: json["card_type"],
    expirationDate: json["expiration_date"] != null ? DateTime.parse(json["expiration_date"]) : null,
    cvv: json["cvv"],
    addressCode: json["address_code"],
    isDefault: json["is_default"], // Lỗi xảy ra ở đây
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (userId != null) "user_id": userId,
    "account_number": accountNumber,
    "account_name": accountName,
    "payment_method": paymentMethod,
    if (providerName != null) "provider_name": providerName,
    if (cardType != null) "card_type": cardType,
    if (expirationDate != null)
      "expiration_date": "${expirationDate!.year.toString().padLeft(4, '0')}-${expirationDate!.month.toString().padLeft(2, '0')}-${expirationDate!.day.toString().padLeft(2, '0')}",
    if (cvv != null) "cvv": cvv,
    if (addressCode != null) "address_code": addressCode,
    "is_default": isDefault,
    if (createdAt != null) "created_at": createdAt!.toIso8601String(),
    if (updatedAt != null) "updated_at": updatedAt!.toIso8601String(),
  };
}