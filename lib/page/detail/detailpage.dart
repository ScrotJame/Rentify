import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentify/morewidget/widShowMore.dart';
import 'package:rentify/page/detail/amenities_page.dart';
import 'package:rentify/page/detail/amentity_item.dart';
import 'package:rentify/page/item_explore.dart';
import 'package:rentify/viewmodel/home_page_modelview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../bean/property_image.dart';

class DetailPage extends StatefulWidget {
  final int propertyId;
  const DetailPage({super.key, required this.propertyId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

// Hình ảnh bìa
class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  bool showAll = false;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
    'https://th.bing.com/th/id/OIP.gKNPSYRFvcET_UrJRDUcZQHaE8?w=269&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
  ];

  @override
  void initState() {
    super.initState();
    // Gọi fetchPropertyDetail khi widget được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PropertyViewModel>(context, listen: false)
          .fetchProperties(widget.propertyId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Reset trạng thái khi đóng DetailPage (optional)
    Provider.of<PropertyViewModel>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Consumer<PropertyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Lỗi: ${viewModel.errorMessage}'));
          } else if (viewModel.selectedProperty == null) {
            return const Center(child: Text('Không có dữ liệu'));
          } else {
            final property = viewModel.selectedProperty!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hình ảnh
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: property.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              (property.images[index] as PropertyImage).imageUrl, // Sử dụng imageUrl từ PropertyImage
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                            );
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${_currentIndex + 1}/${property.images.length}",
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tiêu đề và mô tả
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(property.location),
                        const Text(""),
                        // Đánh giá
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 8),
                            Text("${property.rating} | 120 đánh giá",
                                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey[300], thickness: 1),
                        ShowMoreText(
                          text: 'Cần thuê nhà tiện nghi, giá hợp lý? Chúng tôi cho thuê nhà nguyên căn với diện tích rộng rãi, thoáng mát, gồm 2 phòng ngủ, '
                              '1 phòng khách, bếp và WC. Nhà nằm ở vị trí trung tâm, gần chợ, '
                              'trường học, giao thông thuận tiện. Phù hợp cho gia đình nhỏ hoặc nhóm bạn. Hợp đồng linh hoạt, giá cả thương lượng. Liên hệ ngay để xem nhà!',
                        ),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  // Owner
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset('assets/images/avtdefault.jpg', width: 75),
                        ),
                        const Text("Chủ hộ"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  // Item house have
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nơi này có những gì cho bạn",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey[300], thickness: 1),
                        const SizedBox(height: 8),
                        // Column(
                        //   children: property.amenities.map((amenity) =>
                        //       AmenityItem(text: amenity.getAmenityName())
                        //   ).toList(),
                        // ),
                        // if (property.amenities.length > 5)
                        //   TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => AmenitiesPage(propertyId: widget.propertyId),
                        //         ),
                        //       );
                        //     },
                        //     child: Text("Hiển thị tất cả ${property.amenities.length} tiện ích"),
                        //   ),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  // Map
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Map here"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tình trạng phòng"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Chính sách hủy"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nội quy nơi ở"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Thông tin an toàn"),
                        Divider(color: Colors.grey[300], thickness: 1),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}