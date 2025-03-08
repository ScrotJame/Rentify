import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData = {
    "id": 3,
    "name": "Your name",
    "phone": "000000000",
    "avatar": "https://via.placeholder.com/150", // Tạm thay ảnh
    "bio": null,
    "role": "tenant"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userData["avatar"]),
              ),
              SizedBox(height: 16),

              // Name
              Text(
                userData["name"],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Phone
              Text(
                "📞 ${userData["phone"]}",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),

              SizedBox(height: 10),

              // Role
              Chip(
                label: Text(
                  userData["role"].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
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
      ),
    );
  }
}