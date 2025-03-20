import 'package:flutter/material.dart';
import '../../model/propertities.dart';

class BookingBar extends StatelessWidget {
  final VoidCallback? onBookPressed;
  final DetailProperty property;

  const BookingBar({super.key, this.onBookPressed, required this.property});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,    end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFEEDB),
            Color(0xFF96705B),
          ],
          stops: [0.3, 1.0],
        ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Giá: ${double.parse(property.price) / 1000000} triệu/tháng',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Đặt cọc: ${property.deposit != null ? property.deposit.toString() : "Không có đặt cọc"}',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onBookPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFEEDB),
                shadowColor: Color(0xFF96705B),
                elevation:15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Đặt phòng",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget PraseAmount( DetailProperty property) {
  return DraggableScrollableSheet(
    initialChildSize: 0.4, // Chiều cao ban đầu chiếm 40% màn hình
    minChildSize: 0.2,    // Chiều cao tối thiểu khi thu gọn
    maxChildSize: 0.8,    // Chiều cao tối đa khi mở rộng
    builder: (BuildContext context, ScrollController scrollController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thanh kéo
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Tiêu đề
                const Text(
                  'Tùy chọn giá',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Option 1: Giá thuê (price)
                ListTile(
                  title: const Text(
                    'Giá thuê/tháng',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    '${double.parse(property.price) / 1000000} triệu/tháng',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const Divider(),
                // Option 2: Tiền đặt cọc (deposit)
                ListTile(
                  title: const Text(
                    'Tiền đặt cọc',
                    style: TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    property.deposit != null
                        ? '${property.deposit! / 1000000} triệu'
                        : 'Không có đặt cọc',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}