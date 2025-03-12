import 'package:flutter/material.dart';
import 'package:rentify/model/propertities.dart';

class AirbnbExploreItem2 extends StatefulWidget {
  final int ID;
  final String imageUrl;
  final String location;
  final String title;
  final double price;
  final double rating;

  const AirbnbExploreItem2({
    Key? key,
    required this.ID,
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.price,
    required this.rating,
  }) : super(key: key);

  // Factory constructor để tạo từ AllProperty
  factory AirbnbExploreItem2.fromAllProperty(AllProperty property) {
    return AirbnbExploreItem2(
      ID: property.id!,
      imageUrl: property.image.isNotEmpty ? property.image.first.imageUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      location: property.location,
      title: property.title,
      price: double.parse(property.price) / 1000000, // Chuyển đổi giá từ VNĐ sang triệu
      rating: 4.7, // Có thể thêm rating từ API nếu cần
    );
  }
  factory AirbnbExploreItem2.fromResultProperty(ResultProperty property) {
    return AirbnbExploreItem2(
      ID: property.id!,
      imageUrl: property.image.isNotEmpty ? property.image.first.imageUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      location: property.location,
      title: property.title,
      price: double.parse(property.price) / 1000000,
      rating: 4.7,
    );
  }

  @override
  _AirbnbExploreItem2State createState() => _AirbnbExploreItem2State();
}

class _AirbnbExploreItem2State extends State<AirbnbExploreItem2> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  widget.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 50); // Hiển thị icon lỗi nếu load hình thất bại
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: toggleFavorite,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(widget.location, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Text('VND ${widget.price.toStringAsFixed(2)} triệu/month', style: TextStyle(color: Colors.red)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(widget.rating.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
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