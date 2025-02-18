import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentify/page/detailpage.dart';

class AmenitiesPage extends StatefulWidget {
  final List<Map<String, dynamic>> amenities;
  const AmenitiesPage({super.key, required this.amenities});

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  final List<AmenityItem> amenities = [
    AmenityItem(icon: 'assets/icons/image-square-svgrepo-com.svg', text: 'Hướng nhìn ra núi'),
    AmenityItem(icon: 'assets/icons/kitchen-cooker-utensils-svgrepo-com.svg', text: 'Bếp'),
    AmenityItem(icon: 'assets/icons/wifi-svgrepo-com.svg', text: 'Wi-fi'),
    AmenityItem(icon: 'assets/icons/parking-svgrepo-com.svg', text: 'Chỗ đỗ xe miễn phí'),
    AmenityItem(icon: 'assets/icons/bathtub-svgrepo-com.svg', text: 'Bồn tắm nước nóng'),
    AmenityItem(icon: 'assets/icons/tv-svgrepo-com.svg', text: 'TV'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView(
        children: amenities.map((amenity) {
          return ListTile(
            leading: Icon(amenity["icon"], size: 30),
            title: Text(amenity["title"]),
          );
        }).toList(),
      ),
    );
  }
}
class AmenityItem extends StatelessWidget {
  final String icon;
  final String text;

  AmenityItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon, width: 24, height: 24),
      title: Text(text),
      contentPadding: EdgeInsets.zero,
    );
  }
}