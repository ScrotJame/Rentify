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
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId,
    "image_url": imageUrl,
  };
}