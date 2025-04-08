import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  final String text;

  const ShowMoreText({super.key, required this.text});

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.text.trim().split(RegExp(r'\s+'));
    final needsShowMore = words.length > 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _expanded
              ? widget.text
              : needsShowMore
              ? "${words.take(100).join(' ')}..."
              : widget.text,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 8),
        if (needsShowMore)
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: Text(_expanded ? "Show less" : "Show more"),
            ),
          ),
      ],
    );
  }
}