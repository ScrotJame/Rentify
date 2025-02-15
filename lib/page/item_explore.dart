import 'package:flutter/material.dart';

class AirbnbExploreItem2 extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String title;
  final double price;
  final double rating;

  const AirbnbExploreItem2({
    Key? key,
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.price,
    required this.rating,
  }) : super(key: key);

  // Hàm tạo object từ Firebase
  factory AirbnbExploreItem2.fromMap(Map<String, dynamic> data) {
    return AirbnbExploreItem2(
      imageUrl: data['imageUrl'] ?? '',
      location: data['location'] ?? '',
      title: data['title'] ?? '',
      price: (data['price'] as num).toDouble(),
      rating: (data['rating'] as num).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: Colors.white, size: 28),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(location, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Text('\VND ${price.toStringAsFixed(2)}/month', style: TextStyle(color: Colors.red)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(rating.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

