import 'package:flutter/material.dart';

class BookingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // Giới hạn chiều cao của thanh đặt phòng
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Giá tiền
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$120 / đêm",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4), // Khoảng cách giữa hai dòng
                Text(
                  "Đặt cọc trước 500",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),


            // Nút "Đặt phòng" ở góc phải
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  "Đặt phòng",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}


