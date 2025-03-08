import 'package:flutter/material.dart';
import 'package:rentify/page/user/profile/profile_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileBody(),
    );
  }
}

class UserProfileBody extends StatelessWidget {
  final String userName = "John Doe";
  final String userEmail = "johndoe@example.com";
  final String userAvatar = "";

  final List<Map<String, String>> bookings = [
    {"title": "Luxury Apartment", "status": "Confirmed"},
    {"title": "Cozy House", "status": "Pending"},
  ];

  final List<String> favorites = ["Beachfront Villa", "Modern Loft"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(context),
          SizedBox(height: 20),
          _buildSectionTitle("Bookings"),
          _buildBookingList(),
          SizedBox(height: 20),
          _buildSectionTitle("Favorites"),
          _buildFavoriteList(),
          SizedBox(height: 20),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfilePage(),)
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(userAvatar),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(userEmail, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildBookingList() {
    return Column(
      children: bookings.map((booking) {
        return ListTile(
          leading: Icon(Icons.hotel, color: Colors.blueAccent),
          title: Text(booking["title"]!),
          trailing: Chip(label: Text(booking["status"]!)),
        );
      }).toList(),
    );
  }

  Widget _buildFavoriteList() {
    return Column(
      children: favorites.map((fav) {
        return ListTile(
          leading: Icon(Icons.favorite, color: Colors.redAccent),
          title: Text(fav),
        );
      }).toList(),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Text("Logout", style: TextStyle(color: Colors.redAccent)),
      ),
    );
  }
}
