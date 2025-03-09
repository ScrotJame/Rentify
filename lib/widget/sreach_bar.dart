import 'package:flutter/material.dart';
import '../page/search/search_page.dart';

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
        MaterialPageRoute(builder: (context) => Search_Page(),),
      ); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey,
    borderRadius: BorderRadius.circular(30.0),
        ),
    child: Row(
      children: [
    const Expanded(
      child: Text(
        "Bạn muốn tìm gì ?",
        style: TextStyle(color: Colors.white70, fontSize: 11),
      ),
    ),
        const Icon(Icons.location_on, color: Colors.white, size: 16),
      ],
    ),
      ),
    ),

        ],
      ),
    );

  }
}


