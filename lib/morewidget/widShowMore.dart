import 'package:flutter/material.dart';

import '../page/detailspage/amenities_page.dart';

class ShowMoreText extends StatefulWidget {
  final String text;

  const ShowMoreText({super.key, required this.text});


  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}
class ShowMoreAmenities extends StatefulWidget {
  final List<Map<String, String>> amenities; // Danh sách tiện ích
  const ShowMoreAmenities({super.key, required this.amenities});

  @override
  State<ShowMoreAmenities> createState() => _ShowMoreAmenitiesState();
}

class _ShowMoreAmenitiesState extends State<ShowMoreAmenities> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedAmenities =
    _expanded ? widget.amenities : widget.amenities.take(5).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var amenity in displayedAmenities)
          AmenityItem(icon: amenity['icon']!, text: amenity['text']!),

        // Nếu số lượng tiện ích > 5, hiển thị nút "Hiển thị tất cả"
        if (widget.amenities.length > 5)
          OutlinedButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(_expanded ? "Ẩn bớt" : "Hiển thị tất cả ${widget.amenities.length} tiện nghi"),
          ),
      ],
    );
  }
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _expanded
              ? widget.text
              : widget.text.length > 200
              ? "${widget.text.substring(0, 200)}..."
              : widget.text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        if (widget.text.length > 200)
          TextButton(
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Text(
              _expanded ? "Show less" : "Show more",
              style: TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }
}


