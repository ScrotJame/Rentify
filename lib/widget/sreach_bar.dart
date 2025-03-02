import 'package:flutter/material.dart';

class SreachBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Where are you going?",
              hintStyle: TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.black,
            ),
            style: TextStyle(color: Colors.white),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Icon(Icons.location_on, color: Colors.red, size: 30),
          ),
        ],
      ),
    );

  }
}


