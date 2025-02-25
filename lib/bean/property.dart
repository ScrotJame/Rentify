import 'package:flutter/material.dart';
import 'dart:convert' show json, jsonDecode;

import 'package:rentify/bean/property_image.dart';
import 'package:rentify/bean/property_amenities.dart';

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
  final List<PropertyAmenities> amenities;
  final List<PropertyImage> images;
  final List<String> rating;

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
    required this.images,
    required this.rating,
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
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      restroomType: json['restroom_type'] ?? '',
      propertyType: json['property_type'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? 0,
      amenities: (json['amenities'] as List<dynamic>)
            .map((amenity) => PropertyAmenities.fromJson(amenity))
            .toList(),
      images: (json['image'] as List<dynamic>)
          .map((image) => PropertyImage.fromJson(image))
          .toList(),
      rating: json['rating'] == null ? [] : List<String>.from(json['rating'] as List),
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
      'image': images,
      'rating': rating,
    };
  }
}

class AllProperty {
  final int id;
  final String title;
  final String location;
  final String price;
  final List<PropertyImage> image;

  AllProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
  });

  factory AllProperty.fromJson(Map<String, dynamic> json) {
    return AllProperty(
      id: json['id'] as int,
      title: json['title'] as String,
      location: json['location'] as String,
      price: json['price'] as String,
      image: (json['image'] as List<dynamic>)
          .map((e) => PropertyImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'price': price,
      'image': image,
    };
  }

  List<AllProperty> parseProperties(String jsonString) {
    final List<dynamic> parsed = jsonDecode(jsonString)[0];
    return parsed.map((json) => AllProperty.fromJson(json)).toList();
  }
}
