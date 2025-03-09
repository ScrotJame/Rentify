// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:rentify/model/propertities.dart';
//
// class ListProperty extends StatelessWidget {
//   final List<Image> imageUrls; // Thay đổi thành danh sách URL
//   final String title;
//   final String location;
//   final double price;
//   final double rating;
//   final bool isFavorite;
//   final VoidCallback? onFavoriteToggle;
//
//   const ListProperty({
//     super.key,
//     required this.imageUrls,
//     required this.title,
//     required this.location,
//     required this.price,
//     required this.rating,
//     this.isFavorite = false,
//     this.onFavoriteToggle,
//   });
//
//   factory ListProperty.fromDetailProperty(DetailProperty property, {bool isFavorite = false, VoidCallback? onFavoriteToggle}) {
//     return ListProperty(
//       imageUrls: property.images.isNotEmpty
//           ? property.images.map((img) => img.imageUrl).toList()
//           : ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s'],
//       title: property.title,
//       location: property.location,
//       price: double.parse(property.price) / 1000000,
//       rating: 4.7,
//       isFavorite: isFavorite,
//       onFavoriteToggle: onFavoriteToggle,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     height: 180,
//                     viewportFraction: 1.0,
//                     enableInfiniteScroll: imageUrls.length > 1,
//                   ),
//                   items: imageUrls.map((url) {
//                     return Image.network(
//                       url,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Icon(Icons.error, size: 50);
//                       },
//                     );
//                   }).toList(),
//                 ),
//               ),
//               Positioned(
//                 top: 10,
//                 right: 10,
//                 child: GestureDetector(
//                   onTap: onFavoriteToggle,
//                   child: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: isFavorite ? Colors.red : Colors.white,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 5),
//                 Text(location, style: const TextStyle(color: Colors.grey)),
//                 const SizedBox(height: 5),
//                 Text('VND ${price.toStringAsFixed(2)} triệu/tháng', style: const TextStyle(color: Colors.red)),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, color: Colors.orange, size: 16),
//                     Text(rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }