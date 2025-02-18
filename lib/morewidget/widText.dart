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
