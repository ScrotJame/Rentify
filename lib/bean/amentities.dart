import 'package:flutter/material.dart';
import 'dart:convert' show json;

class Amentity {
  final id;
  final name;
  final icon;

  Amentity({
    required this.id,
    required this.name,
    required this.icon,
  });

factory Amentity.fromJson(Map<String, dynamic> json) {
  return Amentity(
    id: json['id'],
    name: json['name'],
    icon: json['icon'],
  );
}
  Map<String, dynamic> toJson() {
  return{
    'id': id,
    'name': name,
    'icon': icon,
  };
  }
}


