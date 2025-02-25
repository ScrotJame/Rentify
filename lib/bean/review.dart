import 'package:flutter/material.dart';
import 'dart:convert' show json;

class ReviewProperty {
  final int id;
  final int id_proprety;
  final int id_user;
  final int rating;
  final String comment;

  ReviewProperty({
    required this.id,
    required this.id_proprety,
    required this.id_user,
    required this.rating,
    required this.comment,
});
  // Factory constructor để ánh xạ từ JSON
  factory ReviewProperty.fromJson(Map<String, dynamic> json) {
    return ReviewProperty(
    id: json['id'] ?? 0,
    id_proprety: json['id_proprety'] ?? 0,
    id_user: json['id_user'] ?? 0,
    rating: json['rating'] ?? 0,
    comment: json['comment'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_proprety': id_proprety,
      'id_user': id_user,
      'rating': rating,
      'comment': comment,
    };
  }
}
