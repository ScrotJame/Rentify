import 'package:flutter/material.dart';
import '../../model/propertities.dart';
import '../../page/viewing/viewings_page.dart';

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
          color: Colors.white,
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
                  property.deposit != null && property.deposit!.isNotEmpty
                      ? 'Đặt cọc: ${(double.parse(property.deposit!) / 1000000).toString()} triệu'
                      : 'Không có đặt cọc',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onBookPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shadowColor: const Color(0xFF96705B),
                elevation: 15,
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

class PraseAmount extends StatefulWidget {
  final DetailProperty property;

  const PraseAmount({super.key, required this.property});

  @override
  State<PraseAmount> createState() => _PraseAmountState();
}

class _PraseAmountState extends State<PraseAmount> {
  String? selectedOption; // Lưu lựa chọn của người dùng: "deposit" hoặc "full"

  @override
  Widget build(BuildContext context) {
    // Kiểm tra xem deposit có giá trị hợp lệ hay không
    bool hasDeposit = widget.property.deposit != null && widget.property.deposit!.isNotEmpty;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.8,
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
                      'Thanh toán toàn bộ',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      '${double.parse(widget.property.price) / 1000000} triệu/tháng',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: Radio<String>(
                      value: 'full',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedOption = 'full';
                      });
                    },
                  ),
                  const Divider(thickness: 1, color: Colors.black),
                  // Option 2: Đặt cọc (deposit)
                  ListTile(
                    title: const Text(
                      'Tiền đặt cọc',
                      style: TextStyle(fontSize: 16),
                    ),
                    subtitle: Text(
                      hasDeposit
                          ? '${double.parse(widget.property.deposit!) / 1000000} triệu'
                          : 'Không có đặt cọc',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: Radio<String>(
                      value: 'deposit',
                      groupValue: selectedOption,
                      onChanged: hasDeposit
                          ? (value) {
                        setState(() {
                          selectedOption = value;
                        });
                      }
                          : null, // Vô hiệu hóa nếu không có deposit
                    ),
                    onTap: hasDeposit
                        ? () {
                      setState(() {
                        selectedOption = 'deposit';
                      });
                    }
                        : null, // Vô hiệu hóa nếu không có deposit
                  ),
                  const SizedBox(height: 20),
                  // Nút xác nhận
                  ElevatedButton(
                    onPressed: selectedOption == null
                        ? null
                        : () {
                      // Tính amount dựa trên lựa chọn
                      double amount;
                      if (selectedOption == 'full') {
                        amount = double.parse(widget.property.price);
                      } else {
                        amount = hasDeposit ? double.parse(widget.property.deposit!) : 0;
                      }

                      // Đóng bottom sheet
                      Navigator.pop(context);

                      // Chuyển đến BookingPage và truyền amount
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            property: widget.property,
                            amount: amount,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xFF96705B),
                    ),
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(color: Colors.white),
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
}