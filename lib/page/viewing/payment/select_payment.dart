import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/viewing/payment/payment_cubit.dart';

import '../../../http/API.dart';

class SelectPaymentPage extends StatelessWidget {
  const SelectPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(context.read<API>()),
      child: Scaffold(
        backgroundColor: Color(0xFF96705B),
        appBar: AppBar(
            backgroundColor: Color(0xFF96705B),
        ),
        body: Stack(
          children: [
            // Gradient nền
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF96705B),
                    Color(0xFFFFEEDB),
                  ],
                  stops: [0.3, 1.0],
                ),
              ),
            ),
            // Nội dung chính
            const SelectPaymentBody(),
          ],
        ),
      ),
    );
  }
}

class SelectPaymentBody extends StatelessWidget {
  const SelectPaymentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is PaymentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Danh sách tài khoản thanh toán',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              BlocBuilder<PaymentCubit, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PaymentSuccess) {
                    if (state.allpaymentAccounts.isEmpty) {
                      return const Center(child: Text('Chưa có tài khoản nào.'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.allpaymentAccounts.length,
                      itemBuilder: (context, index) {
                        final payment = state.allpaymentAccounts[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              payment.accountName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Số tài khoản: ${payment.accountNumber ?? "N/A"}'),
                                Text('Phương thức: ${payment.paymentMethod}'),
                                Text('${payment.isDefault ? "Mặc định" : ""}'),
                              ],
                            ),
                            trailing: Icon(
                              payment.isDefault
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: payment.isDefault ? Colors.green : Colors.grey,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PaymentError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Đang tải danh sách...'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
