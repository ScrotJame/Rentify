// amenity_item.dart
import 'package:flutter/material.dart';

class AmenityItem extends StatelessWidget {
  final String text;

  const AmenityItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // Bạn có thể thêm icon ở đây nếu muốn
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    );
  }
}