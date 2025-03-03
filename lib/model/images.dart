import 'dart:convert';
class Image {
  int propertyId;
  String imageUrl;

  Image({
    required this.propertyId,
    required this.imageUrl,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    propertyId: json["property_id"],
    imageUrl: json["image_url"] ?? 'http://127.0.0.1:8000/images/default_room_5.jpg',
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId,
    "image_url": imageUrl,
  };
}