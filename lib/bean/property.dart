import 'package:flutter/material.dart';
import 'dart:convert' show json;

class DetailProperty {
  final int id;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final String title;
  final String description;
  final String location;
  final String price;
  final String restroomType;
  final String propertyType;
  final String status;
  final int userId;
  final List<String> amenities;
  final List<String> imgProperty;

  // Constructor
  DetailProperty({
    required this.id,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.title,
    required this.description,
    required this.location,
    required this.price,
    required this.restroomType,
    required this.propertyType,
    required this.status,
    required this.userId,
    required this.amenities,
    required this.imgProperty,
  });

  // Factory constructor để ánh xạ từ JSON
  factory DetailProperty.fromJson(Map<String, dynamic> json) {
    return DetailProperty(
      id: json['id'] ?? 0,
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: json['area'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['address'] ?? '',
      price: json['price'] ?? '',
      restroomType: json['restroom_type'] ?? '',
      propertyType: json['property_type'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? 0,
      amenities: List<String>.from(json['amenities'] as List),
      imgProperty: List<String>.from(json['image_url'] as List),
    );
  }

  // Chuyển đối tượng thành JSON (để gửi API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'title': title,
      'description': description,
      'location': location,
      'price': price,
      'restroom_type': restroomType,
      'property_type': propertyType,
      'status': status,
      'user_id': userId,
      'amenities': amenities,
      'image_url': imgProperty,
    };
  }
}

class AllProperty{
  final int id2;
  final String title2;
  final String location2;
  final String price2;
  final List<String> imgProperty2;

  AllProperty({
    required this.id2,
    required this.title2,
    required this.location2,
    required this.price2,
    required this.imgProperty2,
  });

  factory AllProperty.fromJson(Map<String, dynamic> json) {
    return AllProperty(
      id2: json['id'] ?? 0,
      title2: json['title'] ?? '',
      location2: json['address'] ?? '',
      price2: json['price'] ?? '',
      imgProperty2: List<String>.from(json['image_url'] ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id2,
      'title': title2,
      'location': location2,
      'price': price2,
      'image_url': imgProperty2,
    };
  }
}
