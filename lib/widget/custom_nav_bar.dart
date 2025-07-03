import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedFontSize;
  final double? unselectedFontSize;
  final double? iconSize;
  final BottomNavigationBarType type;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedFontSize = 12.0,
    this.unselectedFontSize = 10.0,
    this.iconSize = 24.0,
    this.type = BottomNavigationBarType.fixed,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.bottomNavigationBarTheme.backgroundColor ?? Colors.white;
    final effectiveSelectedItemColor = selectedItemColor ?? theme.bottomNavigationBarTheme.selectedItemColor ?? theme.primaryColor;
    final effectiveUnselectedItemColor = unselectedItemColor ?? theme.bottomNavigationBarTheme.unselectedItemColor ?? Colors.grey;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isSelected = index == selectedIndex;

          return Expanded(
            child: _buildNavigationItem(
              item,
              index,
              isSelected,
              effectiveSelectedItemColor,
              effectiveUnselectedItemColor,
            ),
          );
        }).toList(),
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
    final fontSize = isSelected ? selectedFontSize! : unselectedFontSize!;

    return InkWell(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(2),
              child: isSelected && item.activeIcon != null
                  ? IconTheme(
                data: IconThemeData(
                  color: color,
                  size: iconSize,
                ),
                child: item.activeIcon!,
              )
                  : IconTheme(
                data: IconThemeData(
                  color: color,
                  size: iconSize,
                ),
                child: item.icon,
              ),
            ),

            // Label
            if ((isSelected && showSelectedLabels) || (!isSelected && showUnselectedLabels))
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  item.label ?? '',
                  style: TextStyle(
                    color: color,
                    fontSize: fontSize,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}