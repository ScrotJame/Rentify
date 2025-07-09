import 'package:flutter/material.dart';
import '../page/host/room_manager/Add_room/Add_room_page.dart';
import '../page/search/search_page.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Search_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0,  0,16.0, 0),
      child: Stack(
        children: [
    GestureDetector(
      onTap: () {  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage(),),
      ); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey,
    borderRadius: BorderRadius.circular(30.0),
        ),
    child: const Row(
      children: [
    Expanded(
      child: Text(
        "Bạn muốn tìm gì ?",
        style: TextStyle(color: Colors.white70, fontSize: 11),
      ),
    ),
        Icon(Icons.location_on, color: Colors.white, size: 16),
      ],
    ),
      ),
    ),

        ],
      ),
    );

  }
}

//host
PreferredSizeWidget Add_Room_Bar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(6, 10, 6, 6),
      child: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          // Thêm phòng
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.plusCircle()),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddRoomPage()),
              );
            },
          ),
          // Thay đổi kiểu xem
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.gridNine()),
            onPressed: () {
              // Xử lý chuyển đổi kiểu xem
            },
          ),
          // Tìm kiếm
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.magnifyingGlass()),
            onPressed: () {
              // Xử lý tìm kiếm
            },
          )
        ],
      ),
    ),
  );
}



