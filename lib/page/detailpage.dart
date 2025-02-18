import 'package:flutter/material.dart';
import 'package:rentify/morewidget/widShowMore.dart';
import 'package:rentify/page/detailspage/amenities_page.dart';
import 'package:rentify/page/item_explore.dart';
import 'package:rentify/page/utilities_page.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailPage extends StatefulWidget {
  final int index;
  final List<Map<String, dynamic>> amenities;
  const DetailPage({super.key, required this.index, required this.amenities});

  @override
  State<DetailPage> createState() => listDetail();
}
//hinh anh bia
class listDetail extends State<DetailPage> {
  bool isFavorite = false;
  //amenities
  bool showAll = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  PageController _pageController = PageController();
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    //amenities
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AmenitiesPage(amenities: widget.amenities),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.grey),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; // Toggle state
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hinh anh
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${_currentIndex + 1}/${imageUrls.length}",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Tieu de va mo ta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Căn hộ cao cấp tại Hà Nội",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text("Nhà ở cho dân | 3tr/ tháng"),
                  Text(""),
                  //Danh gia
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text("4.5 | 120 đánh giá",
                          style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey[300], thickness: 1),
                  ShowMoreText(text: 'Cần thuê nhà tiện nghi, giá hợp lý? Chúng tôi cho thuê nhà nguyên căn với diện tích rộng rãi, thoáng mát, gồm 2 phòng ngủ, '
                      '1 phòng khách, bếp và WC. Nhà nằm ở vị trí trung tâm, gần chợ, '
                      'trường học, giao thông thuận tiện. Phù hợp cho gia đình nhỏ hoặc nhóm bạn. Hợp đồng linh hoạt, giá cả thương lượng. Liên hệ ngay để xem nhà!',),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            //Owner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Thong tin them
                  ClipOval(child:
                  Image.asset('assets/images/avtdefault.jpg', width: 75),
                  ),
                  Text("Chu ho"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            //Item house have
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nơi này có những gì cho bạn",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey[300], thickness: 1),
                  SizedBox(height: 8),
                  Column(
                    children: displayAmenities.map((e) => e).toList(),
                  ),
                  if (widget.amenities.length > 5)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          showAll = !showAll;
                        });
                      },
                      child: Text(showAll ? "Ẩn bớt" : "Hiển thị tất cả ${widget.amenities.length} tiện ích"),
                    ),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            //Map
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Map here"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tinh trang phong"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Thong tin them
                  Text("Chinh sach huy"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Thong tin them
                  Text("Noi quy noi o"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Thong tin them
                  Text("Thong tin an toan"),
                  Divider(color: Colors.grey[300], thickness: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

