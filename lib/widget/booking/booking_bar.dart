import 'package:flutter/material.dart';
import 'package:rentify/model/pay/paymentAccounts.dart';
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
            OutlinedButton(
              onPressed: onBookPressed,
              style: OutlinedButton.styleFrom(
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
  static const String route = '/praseAmount';
  const PraseAmount({super.key, required this.property});

  @override
  State<PraseAmount> createState() => _PraseAmountState();
}

class _PraseAmountState extends State<PraseAmount> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    bool hasDeposit = widget.property.deposit != null && widget.property.deposit!.isNotEmpty;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                  const Text(
                    'Tùy chọn giá',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedOption = 'full';
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: selectedOption == 'full' ? const Color(0xFF96705B) : Colors.white,
                            foregroundColor: selectedOption == 'full' ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: selectedOption == 'full' ? const Color(0xFF96705B) : Colors.grey,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Column(
                            children: [
                              const Text('Thanh toán toàn bộ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('${double.parse(widget.property.price) / 1000000} triệu/tháng',
                                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: hasDeposit
                              ? () {
                            setState(() {
                              selectedOption = 'deposit';
                            });
                          }
                              : null,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: selectedOption == 'deposit' ? const Color(0xFF96705B) : Colors.white,
                            foregroundColor: selectedOption == 'deposit' ? Colors.white : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: selectedOption == 'deposit' ? const Color(0xFF96705B) : Colors.grey,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Column(
                            children: [
                              const Text('Tiền đặt cọc', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                hasDeposit ? '${double.parse(widget.property.deposit!) / 1000000} triệu' : 'Không có đặt cọc',
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 50),
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
                      Navigator.pop(context);
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