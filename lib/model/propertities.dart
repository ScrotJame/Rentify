import 'dart:convert';
import 'images.dart';
import 'amenities.dart';
import 'user.dart';

class DetailProperty {
  int? id;
  String title;
  String description;
  String location;
  String price;
  int? bedrooms;
  int? bathrooms;
  int? area;
  String typeRestroom;
  String propertyType;
  String status;
  int? userId;
  User user;
  List<Amenity> amenities;
  List<Image> image;

  DetailProperty({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.typeRestroom,
    required this.propertyType,
    required this.status,
    required this.userId,
    required this.user,
    required this.amenities,
    required this.image,
  });

  factory DetailProperty.fromJson(Map<String, dynamic> json) => DetailProperty(
    id: json["id"] as int ?? 0,
    title: json["title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    area: json["area"],
    typeRestroom: json["type_restroom"],
    propertyType: json["property_type"],
    status: json["status"],
    userId: json["user_id"],
    user: User.fromJson(json["user"]),
    amenities: List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "price": price,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "area": area,
    "type_restroom": typeRestroom,
    "property_type": propertyType,
    "status": status,
    "user_id": userId,
    "user": user.toJson(),
    "amenities": List<dynamic>.from(amenities.map((x) => x.toJson())),
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}

class AllProperty {
  int id;
  String title;
  String location;
  String price;
  List<Image> image;

  AllProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
  });

  factory AllProperty.fromJson(Map<String, dynamic> json) => AllProperty(
    id: json["id"],
    title: json["title"],
    location: json["location"],
    price: json["price"],
    image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "location": location,
    "price": price,
    "image": List<dynamic>.from(image.map((x) => x.toJson())),
  };
}







