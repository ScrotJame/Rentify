import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/http/API.dart';
import 'package:rentify/page/viewing/payment/payment_cubit.dart';
import 'package:rentify/page/viewing/payment/payment_page.dart';
import 'package:rentify/page/viewing/payment/select_payment.dart';
import 'package:rentify/page/viewing/viewing_cubit.dart';
import 'package:rentify/model/propertities.dart';
import '../../model/pay/paymentAccounts.dart';
import 'date_cubit.dart';

class BookingPage extends StatelessWidget {
  final DetailProperty property;
  final double amount;
  static const String route = '/bookings';

  const BookingPage({
    super.key,
    required this.property,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DateCubit>(create: (context) => DateCubit()),
        BlocProvider<ViewngCubit>(create: (context) => ViewngCubit(context.read<API>()),),
        BlocProvider<PaymentCubit>(create: (context) => PaymentCubit(context.read<API>()),),
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

          child: BodyContain(property: property, amount: amount),
        ),
      ),
    );
  }
}

class BodyContain extends StatelessWidget {
  final DetailProperty property;
  final double amount;

  const BodyContain({
    super.key,
    required this.property,
    required this.amount,
  });

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
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
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
                  const SizedBox(height: 10),
                  Text(
                    'Số tiền thanh toán: ${amount / 1000000} triệu',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
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
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Nhắn tin cho chủ nhà',
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
                return BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, paymentState) {
                    //Chon tai khoan thanh toan
                    PaymentAccount? selectedAccount;
                    if (paymentState is PaymentSuccess) {
                      selectedAccount = paymentState.selectedAccount ?? paymentState.defaultPaymentAccount;
                    }

                    return ElevatedButton(
                      onPressed: state.isLoading || selectedAccount == null
                          ? null
                          : () {
                        final selectedDate = context.read<DateCubit>().state;
                        if (selectedDate != null) {
                          context.read<ViewngCubit>().addBooking(
                            property.id,
                            selectedDate.toString(),
                            selectedAccount!.id!,
                            amount,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Vui lòng chọn ngày bắt đầu')
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF96705B),
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Xác nhận đặt phòng',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
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

  String _maskCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.length < 4) return "Chưa có tài khoản mặc định";
    return "************ ${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        // Xử lý trạng thái loading
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Xử lý trạng thái lỗi
        if (state is PaymentError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Lấy defaultPaymentAccount từ PaymentSuccess
        PaymentAccount? defaultAccount;
        if (state is PaymentSuccess) {
          defaultAccount = state.defaultPaymentAccount;
        }

        // Lấy propertyId và selectedDate
        final bodyContain = context.findAncestorWidgetOfExactType<BodyContain>();
        final int? propertyId = bodyContain?.property.id;
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
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: defaultAccount != null ? Colors.blue : Colors.grey,
                width: 1,
              ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Hiển thị loại thẻ (paymentMethod)
                      Row(
                        children: [
                          const Text(
                            "Loại thẻ: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            defaultAccount?.paymentMethod ?? "Chưa chọn",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Hiển thị số thẻ (accountNumber)
                      Row(
                        children: [
                          const Text(
                            "Số thẻ: ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            _maskCardNumber(defaultAccount?.accountNumber),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}