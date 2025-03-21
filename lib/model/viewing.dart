import 'pay/paymentAccounts.dart';

class Booking {
  String message;
  Data data;

  Booking({
    required this.message,
    required this.data,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Viewing viewing;

  Data({
    required this.viewing,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    viewing: Viewing.fromJson(json["viewing"]),
  );

  Map<String, dynamic> toJson() => {
    "viewing": viewing.toJson(),
  };
}

class Viewing {
  int propertyId;
  int userId;
  DateTime viewingTime;
  int paymentId;
  String status;
  int id;
  PaymentAccount paymentAccount;

  Viewing({
    required this.propertyId,
    required this.userId,
    required this.viewingTime,
    required this.paymentId,
    required this.status,
    required this.id,
    required this.paymentAccount,
  });

  factory Viewing.fromJson(Map<String, dynamic> json) => Viewing(
    propertyId: json["property_id"],
    userId: json["user_id"],
    viewingTime: DateTime.parse(json["viewing_time"]),
    paymentId: json["payment_id"],
    status: json["status"],
    id: json["id"],
    paymentAccount: PaymentAccount.fromJson(json["payment_account"]),
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId,
    "user_id": userId,
    "viewing_time": viewingTime.toIso8601String(),
    "payment_id": paymentId,
    "status": status,
    "id": id,
    "payment_account": paymentAccount.toJson(),
  };
}