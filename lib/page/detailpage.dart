import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentify/firebase_options.dart';
import 'package:rentify/page/item_explore.dart';

class DetailPage extends StatefulWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  State<DetailPage> createState() => listDetail();
}
//hinh anh bia
class listDetail extends State<DetailPage> {
  final List<String> imageUrls = [
    'https://nhahangdungtien.com/images/2023/11/22/large/4563homestay-ba-vi-14.jpg',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://nhahangdungtien.com/images/2023/11/22/large/4563homestay-ba-vi-14.jpg',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://nhahangdungtien.com/images/2023/11/22/large/4563homestay-ba-vi-14.jpg',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider hình ảnh chính
        Stack(
          children: [
            CarouselSlider(
              items: imageUrls.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
              ],
            ),
        )
      ],
    );
  }
}

