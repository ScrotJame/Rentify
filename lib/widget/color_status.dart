import 'dart:ui';
import 'package:flutter/material.dart';

Color getStatusColor(String? status) {
  switch (status) {
    case 'available':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'rented':
      return Colors.red;
    default:
      return const Color(0xFF96705B);
  }
}