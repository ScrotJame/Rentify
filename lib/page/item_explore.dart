import 'package:flutter/material.dart';

import '../bean/property_image.dart';

class AirbnbExploreItem2 extends StatefulWidget {
  final List<PropertyImage> imageUrl;
  final String location;
  final String title;
  final String price;
  // final double rating;

  const AirbnbExploreItem2({
    Key? key,
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.price,
    // required this.rating,
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
                child: widget.imageUrl.isNotEmpty
                  ? Image.network(
                  widget.imageUrl[0].imageUrl, // Lấy ảnh đầu tiên
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                )
                    : const Center(child: Text('No Image')), // Show text if no image
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
                Text('VND ${widget.price}/month', style: TextStyle(color: Colors.red)),
                // Row(
                //   children: [
                //     Icon(Icons.star, color: Colors.orange, size: 16),
                //     Text(widget.rating.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


