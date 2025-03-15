import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData = {
    "id": 3,
    "name": "Your name",
    "phone": "000000000",
    "avatar": "https://picsum.photos/200/300", // Tạm thay ảnh
    "bio": null,
    "role": "tenant"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child:  BodyProfile(userData: userData),
        ),
    );
  }
}

class BodyProfile extends StatelessWidget {
  const BodyProfile({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
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
                          backgroundImage: NetworkImage(userData["avatar"]),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          userData["role"].toUpperCase(),
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
                            userData["name"] ?? "Unknown User",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Divider(color: Colors.grey, thickness: 1),
                          SelectableText(
                            "📞 ${userData["phone"] ?? "N/A"}",
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                          Divider(color: Colors.grey, thickness: 1),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              Text( "4.5 ",  style: TextStyle(fontSize: 16, color: Colors.grey),
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
                userData["bio"] ?? "Chưa có mô tả",
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
  }
}