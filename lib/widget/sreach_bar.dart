import 'package:flutter/material.dart';
import '../page/search/search_page.dart';

class Search_Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(46.0, 16.0, 46.0, 10),
      child: Stack(
        children: [
    GestureDetector(
      onTap: () {  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search_Page(),),
      ); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey,
    borderRadius: BorderRadius.circular(30.0),
        ),
    child: Row(
      children: [
    const Expanded(
      child: Text(
        "Where are you going?",
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
    ),
        const Icon(Icons.location_on, color: Colors.red, size: 30),
      ],
    ),
      ),
    ),

        ],
      ),
    );

  }
}


