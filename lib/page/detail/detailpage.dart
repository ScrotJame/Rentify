import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/morewidget/widText.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentify/page/moreamenities/more_amenities_page.dart';
import '../../http/API.dart';
import '../booking/booking_bar.dart';
import '../booking/booking_cubit.dart';
import '../owner.dart';
import '../viewing/date_cubit.dart';
import 'detail_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class DetailPage extends StatelessWidget {
  final int? id;
  static const String route = 'detail';
  final String baseUrl = 'http://192.168.162.227:8000/api';

  const DetailPage({super.key, required this.id});

  Future<Uint8List?> fetchImage(String url) async {
    const int maxRetries = 3;
    for (int i = 0; i < maxRetries; i++) {
      try {
        final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          return response.bodyBytes;
        }
      } catch (e) {
        print('Retry ${i + 1}/$maxRetries: $e');
        if (i == maxRetries - 1) return null;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF96705B),
          title: const Text('Lỗi'),
        ),
        body: const Center(
          child: Text('Không tìm thấy ID bất động sản'),
        ),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DetailCubit(context.read<API>())..fetchPropertyDetail(id!)),
        BlocProvider(create: (context) => BookingCubit()),
        BlocProvider(create: (context) => DateCubit()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFFFEEDB),
        appBar: AppBar(
          backgroundColor: const Color(0xFF96705B),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.grey,
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
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('Lỗi: ${state.error}'));
            }
            if (state.property == null) {
              return const Center(child: Text('Không tìm thấy bất động sản'));
            }
            final property = state.property!;
            return Container(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hình ảnh
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          if (property.image.isNotEmpty)
                            PageView.builder(
                              itemCount: property.image.length,
                              itemBuilder: (context, index) {
                                final imageUrl = property.image[index].imageUrl.startsWith('http')
                                    ? property.image[index].imageUrl
                                    : '$baseUrl/${property.image[index].imageUrl}';
                                return FutureBuilder<Uint8List?>(
                                  future: fetchImage(imageUrl),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError || snapshot.data == null) {
                                      print('Error loading image: ${snapshot.error}, URL: $imageUrl');
                                      return const Icon(Icons.error, size: 50);
                                    }
                                    return Image.memory(
                                      snapshot.data!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                );
                              },
                            )
                          else
                            const Center(
                              child: Text(
                                "Không có hình ảnh",
                                style: TextStyle(fontSize: 16, color: Colors.grey),
                              ),
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
                                '${property.image.length} ảnh',
                                style: const TextStyle(color: Colors.white),
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: property.status == 'available'
                                      ? Colors.green
                                      : property.status == 'rented'
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                property.status == 'available'
                                    ? 'Còn trống'
                                    : property.status == 'rented'
                                    ? 'Đã thuê'
                                    : 'Đang chờ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.black, thickness: 1),
                          Text(
                            "Nhà ở cho dân | ${double.parse(property.price) / 1000000} triệu/tháng",
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/dorm-room.svg',
                                      width: 15,
                                      height: 15,
                                      color: Colors.black,
                                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Số phòng: ${property.bedrooms}",
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/user.svg',
                                      width: 15,
                                      height: 15,
                                      color: Colors.black,
                                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Tối đa: ${property.bedrooms}",
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/toilet.svg',
                                      width: 15,
                                      height: 15,
                                      color: Colors.black,
                                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        property.typeRestroom == "private" ? "Vệ sinh khép kín" : "Vệ sinh chung",
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/city.svg',
                                      width: 15,
                                      height: 15,
                                      color: Colors.black,
                                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        "Loại: ${property.propertyType.toLowerCase()}",
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 8),
                              Text(
                                "4.5 | 120 đánh giá",
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(color: Colors.grey, thickness: 1),
                          ShowMoreText(
                            text: property.description ?? 'Không có mô tả',
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                        ],
                      ),
                    ),
                    // Chủ nhà
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OwnerPage(id: property.id,)),
                              );
                            },
                            child: ClipOval(
                              child: FutureBuilder<Uint8List?>(
                                future: fetchImage(
                                  property.user.avatar.startsWith('http')
                                      ? property.user.avatar
                                      : '$baseUrl/${property.user.avatar}',
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError || snapshot.data == null) {
                                    return const Icon(Icons.error, size: 50);
                                  }
                                  return Image.memory(
                                    snapshot.data!,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                property.user.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Xếp hạng: 4.8 ⭐",
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    // Tiện ích
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nơi này có",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          if (property.amenities != null && property.amenities.isNotEmpty)
                            ...property.amenities.map((amenity) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/${amenity.iconAmenities ?? 'default'}.svg',
                                      width: 35,
                                      height: 35,
                                      color: Colors.black,
                                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      amenity.nameAmenities ?? 'Không có tên',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                          else
                            const Text(
                              "Không có tiện ích nào được liệt kê",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),

                          const SizedBox(height: 20),
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UtilitiesPage(id: property.id)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(50, 50),
                              ),
                              child: const Text("Xem tất cả tiện nghi"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Maps", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: Center(child: Text("Bản đồ vị trí: ${property.location}")),
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                          const Text("Đánh giá", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Text("4.5 | 120 đánh giá", style: TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                          const Divider(color: Colors.grey, thickness: 1),
                        ],
                      ),
                    ),
                    // Gặp gỡ chủ nhà
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Gặp gỡ chủ nhà của bạn", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Thông tin của chủ nhà:', style: TextStyle(fontSize: 14)),
                              Text(property.user.bio ?? 'Không có thông tin', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side: const BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: const Text(
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
              ),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            final _property = state.property;
            if (_property == null) {
              return const SizedBox.shrink();
            }
            return BookingBar(
              onBookPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  builder: (context) => PraseAmount(property: _property),
                );
              },
              property: _property,
            );
          },
        ),
      ),
    );
  }
}