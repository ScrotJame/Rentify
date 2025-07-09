import 'package:flutter/material.dart';

class LodgeBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final VoidCallback? onCenterButtonPressed; // Callback cho nút giữa
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? iconSize;
  final Color? centerButtonColor;
  final double? centerButtonSize;
  final Widget? centerIcon; // Icon tùy chỉnh cho nút giữa
  final double? centerIconSize; // Kích thước icon giữa

  const LodgeBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.onCenterButtonPressed,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.iconSize = 24.0,
    this.centerButtonColor,
    this.centerButtonSize = 60.0,
    this.centerIcon,
    this.centerIconSize = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? Colors.white;
    final effectiveSelectedItemColor = selectedItemColor ?? const Color(0xFFFF6B4A);
    final effectiveUnselectedItemColor = unselectedItemColor ?? Colors.grey;
    final effectiveCenterButtonColor = centerButtonColor ?? const Color(0xFFFF6B4A);

    return Container(
      height: 97,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Thanh navigation bo tròn
          Container(
            margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
            height: 55,
            decoration: BoxDecoration(
              color: effectiveBackgroundColor,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Icon bên trái (Tab 0: House)
                if (items.isNotEmpty)
                  _buildNavigationItem(
                    items[0],
                    0,
                    selectedIndex == 0,
                    effectiveSelectedItemColor,
                    effectiveUnselectedItemColor,
                  ),

                // Icon thứ 2 (Tab 1: Favorite)
                if (items.length > 1)
                  _buildNavigationItem(
                    items[1],
                    1,
                    selectedIndex == 1,
                    effectiveSelectedItemColor,
                    effectiveUnselectedItemColor,
                  ),

                // Khoảng trống cho nút trung tâm (Tab 2: Explore sẽ hiển thị ở đây)
                SizedBox(width: centerButtonSize! + 10),

                // Icon thứ 3 (Tab 3: Messenger)
                if (items.length > 3)
                  _buildNavigationItem(
                    items[3],
                    3,
                    selectedIndex == 3,
                    effectiveSelectedItemColor,
                    effectiveUnselectedItemColor,
                  ),

                // Icon bên phải (Tab 4: User)
                if (items.length > 4)
                  _buildNavigationItem(
                    items[4],
                    4,
                    selectedIndex == 4,
                    effectiveSelectedItemColor,
                    effectiveUnselectedItemColor,
                  ),
              ],
            ),
          ),

          // Nút trung tâm nổi bật (Tab 2: Explore)
          if (centerIcon != null)
            Positioned(
              bottom: 35,
              child: GestureDetector(
                onTap: onCenterButtonPressed,
                child: Container(
                  width: centerButtonSize,
                  height: centerButtonSize,
                  decoration: BoxDecoration(
                    color: selectedIndex == 2 ? effectiveCenterButtonColor : effectiveCenterButtonColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: effectiveCenterButtonColor.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: centerIcon,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
      BottomNavigationBarItem item,
      int index,
      bool isSelected,
      Color selectedColor,
      Color unselectedColor,
      ) {
    final color = isSelected ? selectedColor : unselectedColor;
    Widget iconWidget = isSelected && item.activeIcon != null
        ? item.activeIcon!
        : item.icon;

    if (iconWidget is Icon) {
      iconWidget = Icon(
        iconWidget.icon,
        color: color,
        size: iconSize,
      );
    } else if (iconWidget is Badge) {
      final child = iconWidget.child;
      if (child is Icon) {
        iconWidget = Badge(
          label: iconWidget.label,
          child: Icon(
            child.icon,
            color: color,
            size: iconSize,
          ),
        );
      }
    }
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: iconWidget,
      ),
    );
  }
}