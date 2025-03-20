import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/http/API.dart';
import 'package:rentify/page/viewing/payment/payment_page.dart';
import 'package:rentify/page/viewing/payment/select_payment.dart';
import 'package:rentify/page/viewing/viewing_cubit.dart';
import 'package:rentify/model/propertities.dart';
import 'date_cubit.dart';

class BookingPage extends StatelessWidget {
  final DetailProperty property;
  static const String route = 'booking';

  const BookingPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateCubit>(create: (context) => DateCubit()),
        BlocProvider<ViewngCubit>(
          create: (context) => ViewngCubit(context.read<API>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF96705B),
        appBar: AppBar(
          backgroundColor: Color(0xFF96705B),
          elevation: 0,
          title: const Text(
            'Yêu cầu đặt phòng',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
        ),
    body: Container(
    // Áp dụng gradient
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,    end: Alignment.bottomCenter,
        colors: [
          Color(0xFF96705B),
          Color(0xFFFFEEDB),
        ],
        stops: [0.3, 1.0],
      ),
    ),
      child: BodyContain(property: property),
    ),
      ),
    );
  }
}

class BodyContain extends StatelessWidget {
  final DetailProperty property;

  const BodyContain({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin đặt phòng ${property.id}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12), // Bo góc cho đẹp
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Màu bóng nhẹ
                    blurRadius: 6, // Độ mờ bóng
                    spreadRadius: 2, // Mức lan tỏa của bóng
                    offset: const Offset(0, 3), // Đổ bóng theo trục y
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12), // Padding để nội dung không dính sát
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: property.image.isNotEmpty
                              ? property.image.first.imageUrl
                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
                          width: 95,
                          height: 95,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error, size: 50),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          property.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Giá phòng: ${double.parse(property.price) / 1000000} triệu/tháng',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<DateCubit, DateTime?>(
              builder: (context, selectedDate) {
                return GestureDetector(
                  onTap: () => context.read<DateCubit>().selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.redAccent),
                        const SizedBox(width: 10),
                        Text(
                          selectedDate != null
                              ? selectedDate.toString().split(' ')[0]
                              : 'Chọn ngày',
                          style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            PaymentWidget(),
            const SizedBox(height: 26),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nhăn tin cho chủ nhà',
                  border: InputBorder.none,
                ),
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 26),
            BlocConsumer<ViewngCubit, ViewngState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đặt phòng thành công!')),
                  );
                  Navigator.pop(context);
                } else if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi: ${state.error}')),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                    final selectedDate =
                        context.read<DateCubit>().state;
                    if (selectedDate != null) {
                      context.read<ViewngCubit>().addBooking(
                        property.id,
                        selectedDate.toString(),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Vui lòng chọn ngày bắt đầu')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color(0xFF96705B),
                  ),
                  child: state.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Xác nhận đặt phòng',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewngCubit, ViewngState>(
      builder: (context, state) {
        final selectedAccount = state.selectedAccount;

        // Lấy propertyId từ BodyContain một cách an toàn
        final bodyContain = context.findAncestorWidgetOfExactType<BodyContain>();
        final int? propertyId = bodyContain?.property.id; // Kiểm tra null
        final DateTime? selectedDate = context.read<DateCubit>().state;

        return GestureDetector(
          onTap: propertyId != null
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectPaymentPage(
                  propertyId: propertyId,
                  viewingTime: selectedDate?.toString() ?? '',
                ),
              ),
            );
          }
              : null, // Vô hiệu hóa onTap nếu propertyId là null
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Phương thức thanh toán",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            selectedAccount?.accountName ?? "Chưa chọn phương thức",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedAccount?.accountNumber ?? "Chưa chọn",
                            style: const TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.black54),
              ],
            ),
          ),
        );
      },
    );
  }
}
