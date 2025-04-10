import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../http/API.dart';
import '../user_cubit.dart';

class ProfilePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      UserCubit(context.read<API>())
        .. fecthUser(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SafeArea(
          child: BodyProfile(),
        ),
      ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {if (state.isLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state.error != null) {
        return Center(child: Text('Lỗi: ${state.error}'));
      }
      if (state.userCb == null) {
        return Center(child: Text('Không tìm thấy bất động sản'));
      }
      final user = state.userCb!;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.avatar),
                          ),
                          SizedBox(height: 10,),
                          Text(
                              user.roles.join(', ').toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? "Unknown User",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight
                                  .bold),
                            ),
                            Divider(color: Colors.grey, thickness: 1),
                            SelectableText(
                              "📞 ${user.phone ?? "N/A"}",
                              style: TextStyle(fontSize: 16, color: Colors
                                  .grey[700]),
                            ),
                            Divider(color: Colors.grey, thickness: 1),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                Text("4.5 ", style: TextStyle(
                                    fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Bio
                Text(
                  user.bio ?? "Chưa có mô tả",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 30),
                // Button Edit Profile
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Chỉnh sửa hồ sơ"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}