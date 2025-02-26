import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Thêm nếu dùng cached_network_image

class AirbnbExploreItem2 extends StatefulWidget {
  final int propertyId;
  final String location;
  final String title;
  final String price;
  final String imageUrl; // Giữ lại nếu cần, nhưng chỉ dùng một ảnh

  const AirbnbExploreItem2({
    Key? key,
    required this.propertyId,
    required this.location,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

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
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: CachedNetworkImage( // Sử dụng CachedNetworkImage thay vì ImgWidget
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  width: double.infinity,
                  height: 200, // Đặt kích thước phù hợp
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
                const SizedBox(height: 5),
                Text(widget.location, style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                Text('VND ${widget.price}/month', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}