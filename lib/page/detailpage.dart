import 'package:flutter/material.dart';
import 'package:rentify/morewidget/widText.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rentify/page/item_explore.dart';
import 'package:rentify/page/utilities_page.dart';
import '../model/propertities.dart';
import '../widget/booking_bar.dart';
import 'owner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailPage extends StatelessWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
    ];
    final List<Map<String, String>> amenities = [
      {'icon': 'assets/icons/air-conditioning-ind.svg', 'label': 'Điều hoà'},
      {'icon': 'assets/icons/wifi.svg', 'label': 'Wi-Fi'},
      {'icon': 'assets/icons/tv-alt.svg', 'label': 'TV'},
      {'icon': 'assets/icons/kitchen-cooker-utensils.svg', 'label': 'Bếp'},
      {'icon': 'assets/icons/parking-garage-transportation-car-parking.svg', 'label': 'Bãi đỗ xe'},
    ];


    // Since we can't use setState in StatelessWidget, we'll manage favorite state differently
    // For demonstration, we'll keep it simple and not persist the state
    bool isFavorite = false; // This won't persist across rebuilds

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              // Since this is stateless, we can't toggle state here.
              // You might want to use a state management solution like Provider or Riverpod for this.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Favorite toggled (Stateless limitation)")),
              );
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
                    itemCount: imageUrls.length,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "1/${imageUrls.length}", // Static for stateless, needs state management for dynamic
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tieu de va mo ta
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Căn hộ cao cấp tại Hà Nội",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text("Nhà ở cho dân | 3tr/ tháng"),
                  Text(""),
                  // Danh gia
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "4.5 | 120 đánh giá",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey, thickness: 1),
                  ShowMoreText(
                    text:
                    'Cần thuê nhà tiện nghi, giá hợp lý? Chúng tôi cho thuê nhà nguyên căn với diện tích rộng rãi, thoáng mát, gồm 2 phòng ngủ, '
                        '1 phòng khách, bếp và WC. Nhà nằm ở vị trí trung tâm, gần chợ, '
                        'trường học, giao thông thuận tiện. Phù hợp cho gia đình nhỏ hoặc nhóm bạn. Hợp đồng linh hoạt, giá cả thương lượng. Liên hệ ngay để xem nhà!',
                  ),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
            // Chu nha
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OwnerPage()),
                      );
                    },
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avtdefault.jpg',
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên chủ phòng",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Xếp hạng: 4.8 ⭐",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            //Tien ich
            ),Divider(color: Colors.grey, thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nơi này có",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: amenities.map((amenity) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12), // Tạo khoảng cách giữa các dòng
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            amenity['icon']!,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Text(amenity['label']!, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                OutlinedButton(
                  onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UtilitiesPage()),
                  );},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(50, 50),
                  ),
                  child: Text("Xem tat ca tien nghi"),
                ),
              ],
            ),
          ),
            Divider(color: Colors.grey, thickness: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thong tin them
                  ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/avtdefault.jpg'),
                      width: 75,
                    ),
                  ),
                  Text("Maps"),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thong tin them
                  ClipOval(
                    child: Image(
                      image: AssetImage('assets/images/avtdefault.jpg'),
                      width: 75,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Text("danh gia"),
                      ],
                  ),

                  const Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gap go chu nha cua ban"),
                  OwnerWigget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thong tin cua chu nha:'),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bo góc
                        ),
                        side: BorderSide( // Viền ngoài
                          color: Colors.red, // Màu viền
                          width: 2, // Độ dày viền
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        "Nhắn tin cho chủ nhà",
                        style: TextStyle(color: Colors.red, fontSize: 16), // Chữ cùng màu với viền
                      ),
                    ),
                  ),


                ],
              ),
            ),const Divider(color: Colors.grey, thickness: 1),
          ],
        ),
      ),
      bottomNavigationBar: BookingBar(),
    );
  }
}