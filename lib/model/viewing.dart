import 'pay/paymentAccounts.dart';

class Bookings {
  String message;
  List<Viewing> data;

  Bookings({
    required this.message,
    required this.data,
  });

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    message: json["message"],
    data: List<Viewing>.from(json["data"].map((x) => Viewing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Viewing {
  int id;
  DateTime viewingTime;
  dynamic message;
  String status;
  int paymentId;
  String title;
  String imageUrl;

  Viewing({
    required this.id,
    required this.viewingTime,
    required this.message,
    required this.status,
    required this.paymentId,
    required this.title,
    required this.imageUrl,
  });

  factory Viewing.fromJson(Map<String, dynamic> json) => Viewing(
    id: json["id"],
    viewingTime: DateTime.parse(json["viewing_time"]),
    message: json["message"],
    status: json["status"],
    paymentId: json["payment_id"],
    title: json["title"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "viewing_time": viewingTime.toIso8601String(),
    "message": message,
    "status": status,
    "payment_id": paymentId,
    "title": title,
    "image_url": imageUrl,
  };
}
