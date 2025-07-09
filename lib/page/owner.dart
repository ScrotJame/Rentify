import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../http/API.dart';
import 'detail/detail_cubit.dart';

class OwnerPage extends StatelessWidget {
  final int? id;
  const OwnerPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => DetailCubit(context.read<API>())
    ..fetchPropertyDetail(id!),
  child: Scaffold(
      appBar: AppBar(
        elevation: 0,
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
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar và thông tin cơ bản
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    property.user.avatar,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          property.user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildInfoItem(Icons.verified, "Verified"),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          "Superhost",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Hosting for 5 years",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Mô tả về chủ nhà
            Text(
              property.user.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
            property.user.bio??" ",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.5, // Khoảng cách dòng
              ),
            ),
            const SizedBox(height: 24),

            // Thông tin bổ sung
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(Icons.comment, "120 Reviews"),
                _buildInfoItem(Icons.language, "English, French"),
              ],
            ),
            const SizedBox(height: 32),

            // Nút liên hệ
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Contacting Anna...")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Contact Host",
                  style: TextStyle(fontSize: 16),
                ),
              ),

            ), const Divider(color: Colors.grey, thickness: 1),
          ],
        ),
      );
  },
),
    ),
);
  }

  // Widget con để hiển thị thông tin bổ sung
  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }
}


class OwnerWigget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Container chính với bóng đổ
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,  // 90% chiều rộng màn hình
                  height: MediaQuery.of(context).size.height * 0.4, // 40% chiều cao màn hình
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),


                // Avatar nổi trên Container
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1, // Scale theo chiều cao của Container
                  left: MediaQuery.of(context).size.width * 0.35, // Scale theo chiều ngang
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avtdefault.jpg',
                      width: MediaQuery.of(context).size.width * 0.2, // Avatar scale theo màn hình
                      height: MediaQuery.of(context).size.width * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25, // Chỉnh vị trí chữ theo chiều cao
                  left: MediaQuery.of(context).size.width * 0.35,
                  child: const Text(
                    "Regular User",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],

            ),
            // Khoảng cách giữa Container và tên user
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(

              ),

            ),
          ],

        ),

      ),
    );

  }
}


