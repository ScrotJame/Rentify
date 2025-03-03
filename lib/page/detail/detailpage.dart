import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/morewidget/widText.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentify/page/item_explore.dart';
import 'package:rentify/page/utilities_page.dart';
import '../../model/propertities.dart';
import '../../widget/booking_bar.dart';
import '../owner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'detail_cubit.dart';

class DetailPage extends StatelessWidget {

  final int? id;
  static const String route = 'detail';
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailCubit>().fetchPropertyDetail(id!);
    bool isFavorite = false;

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Favorite toggled (Stateless limitation)")),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
  builder: (context, state) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return Center(child: Text('Lỗi: ${state.error}'));
    }
    if (state.property == null) {
      return Center(child: Text('Không tìm thấy bất động sản'));
    }
    final property = state.property!;
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hinh anh
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  // PageView.builder(
                  //   itemCount: property.image.length,
                  //   itemBuilder: (context, id) {
                  //     return CachedNetworkImage(
                  //       imageUrl: property.image[id].imageUrl.startsWith('http')
                  //           ? property.image[id].imageUrl
                  //           : 'http://localhost:8000/images/${property.image[id].imageUrl}.jpg', // Fallback nếu không phải URL
                  //       width: 200,
                  //       fit: BoxFit.cover,
                  //       placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  //       errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
                  //     );
                  //   },
                  // ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // child: Text(
                      //   "1/${property.image[id!].imageUrl.length}", // Static for stateless, needs state management for dynamic
                      //   style: const TextStyle(color: Colors.white, fontSize: 14),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Tieu de va mo ta
            // Thông tin cơ bản
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nhà ở cho dân | ${double.parse(property.price) / 1000000} triệu/tháng",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  // Đánh giá
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "4.5 | 120 đánh giá", // Có thể lấy từ API nếu cần
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey, thickness: 1),
                  // Mô tả (ShowMoreText, giả định bạn có widget này)
                  ShowMoreText(
                    text: property.description ?? 'Không có mô tả',
                  ),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
            // Chủ nhà
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                children: [
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const OwnerPage()),
                      // );
                    },
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: property.user.avatar.startsWith('http')
                            ? property.user.avatar
                            : 'http://localhost:8000/images/${property.user.avatar}', // Fallback nếu không phải URL
                        width: 75,
                        height: 75,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property.user.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Xếp hạng: 4.8 ⭐", // Có thể lấy từ API nếu cần
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            // Tiện ích
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
                    // children: property.amenities.map((amenity) {
                    //   return Padding(
                    //     padding: const EdgeInsets.only(bottom: 12),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         // Giả định bạn có widget SvgPicture hoặc Icon từ iconAmenities
                    //         Icon(Icons.check_circle, color: Colors.green, size: 35), // Thay bằng SvgPicture nếu cần
                    //         SizedBox(width: 10),
                    //         Text(
                    //           amenity.nameAmenities,
                    //           style: TextStyle(fontSize: 14),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // }).toList(),
                  ),
                  SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UtilitiesPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(50, 50),
                    ),
                    child: Text("Xem tất cả tiện nghi"),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey, thickness: 1),
            // Thông tin thêm (Maps, đánh giá)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Maps", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // Thêm bản đồ (giả định dùng package như google_maps_flutter)
                  Container(
                    height: 200,
                    color: Colors.grey[300], // Placeholder cho bản đồ
                    child: Center(child: Text("Bản đồ vị trí: ${property.location}")),
                  ),
                  Divider(color: Colors.grey, thickness: 1),
                  Text("Đánh giá", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // Hiển thị đánh giá (giả định, có thể lấy từ API)
                  Text("4.5 | 120 đánh giá", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
            // Gặp gỡ chủ nhà
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Gặp gỡ chủ nhà của bạn", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // OwnerPage(), // Giả định bạn có widget này
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Thông tin của chủ nhà:', style: TextStyle(fontSize: 14)),
                      // Text(property.user.bio, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () {
                        // Thêm logic nhắn tin (ví dụ: điều hướng đến chat page)
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        "Nhắn tin cho chủ nhà",
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1),
          ],
        ),
    );
  },
      ),
      bottomNavigationBar: BookingBar(),
    );
  }
}