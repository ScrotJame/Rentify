import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/host/host.dart';
import 'package:rentify/page/user/profile/profile_page.dart';
import 'package:rentify/page/user/user_cubit.dart';

import '../../http/API.dart';
import '../../widget/tabBar_view.dart';
import '../host/room_manager/room_manager_page.dart';
import '../viewing/payment/payment_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserCubit(context.read<API>())
        .. fecthUser(),
      child: Scaffold(
        body: UserProfileBody(),
      ),
    );
  }
}

class UserProfileBody extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }
        if (state.userCb == null) {
          return const Center(child: Text('Không tìm thấy bất động sản'));
        }
        final user = state.userCb!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(context, user),
              const SizedBox(height: 20),
              _buildSectionTitle("Settings"),
              _buildSettingWigdet(context),
              const SizedBox(height: 20),
              _buildSectionTitle("Welcome tenant"),
              _buildWelcomeWigdet(context),
              const SizedBox(height: 20),
              _buildSectionTitle("Supports"),
              _buildSupportsWigdet(context),
              const SizedBox(height: 20),
              _buildSectionTitle("Legal"),
              const SizedBox(height: 20),
              _buildLogoutButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, dynamic user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(
              user.avatar,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(user.phone ?? 'Chưa có số điện thoại', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildSettingWigdet(BuildContext context){
     return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){print("Đăng nhập và bảo mật được nhấn");},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Đăng nhập và bảo mật",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Colors.grey),
                    GestureDetector(
                      onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentPage()),
                      );},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Thanh toán và chi trả",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ],
      );
  }

  Widget _buildWelcomeWigdet(BuildContext context){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Xác minh tài khoản",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Colors.grey),
                    GestureDetector(
                      onTap: (){

                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lịch sử giao dịch",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Colors.grey),
                    GestureDetector(
                      onTap: (){Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HostMain()),
                      );},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phòng (Chủ)",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportsWigdet(BuildContext context){
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageMain()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hỗ trợ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Colors.grey),
                    GestureDetector(
                      onTap: (){},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Chính sách ứng dụng",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
        title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }



  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          try {
            await context.read<API>().logoutUser();
            Navigator.pushNamed(context, 'LoginScreen');
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lỗi đăng xuất: $e')));
          }
        },
        child: const Text('Đăng xuất'),
      ),
    );
  }
}
