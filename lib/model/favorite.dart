import 'package:rentify/model/propertities.dart';

class Favorite {
  String message;
  List<AllProperty> data;

  Favorite({
    required this.message,
    required this.data,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    message: json["message"],
    data: List<AllProperty>.from(json["data"].map((x) => AllProperty.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}