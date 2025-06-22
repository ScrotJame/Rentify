import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Nền bar bo tròn
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(Icons.bar_chart, 0),
              _buildIcon(Icons.message, 1),
              const SizedBox(width: 50), // khoảng cho nút trung tâm
              _buildIcon(Icons.group, 3),
            ],
          ),
        ),

        // Nút Home trung tâm nổi bật
        Positioned(
          bottom: 40,
          child: GestureDetector(
            onTap: () => onTabSelected(2),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.home, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Icon(
        icon,
        color: isSelected ? Colors.orange : Colors.orange[200],
        size: 28,
      ),
    );
  }
}
