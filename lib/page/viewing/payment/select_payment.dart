import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../http/API.dart';
import '../viewing_cubit.dart';

class SelectPaymentPage extends StatelessWidget {
  final int propertyId;
  final String viewingTime;

  const SelectPaymentPage({
    required this.propertyId,
    required this.viewingTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewngCubit(context.read<API>())..fetchPaymentAccounts(),
      child: Scaffold(
        backgroundColor: const Color(0xFF96705B),
        appBar: AppBar(
          backgroundColor: const Color(0xFF96705B),
          title: const Text('Chọn tài khoản thanh toán'),
        ),
        body: Stack(
          children: [
            // Gradient nền
            Container(

            ),
            // Nội dung chính
            SelectPaymentBody(
              propertyId: propertyId,
              viewingTime: viewingTime,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectPaymentBody extends StatelessWidget {
  final int propertyId;
  final String viewingTime;

  const SelectPaymentBody({
    required this.propertyId,
    required this.viewingTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            BlocBuilder<ViewngCubit, ViewngState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }
                if (state.paymentAccounts.isEmpty) {
                  return const Center(child: Text('Chưa có tài khoản nào.'));
                }

                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.paymentAccounts.length,
                      itemBuilder: (context, index) {
                        final payment = state.paymentAccounts[index];
                        final isSelected = state.selectedAccount == payment;

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
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                            onTap: () {
                              context.read<ViewngCubit>().selectPaymentAccount(payment);
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state.selectedAccount != null
                          ? () {
                        Navigator.pushNamed(
                          context,
                          '/bookings',
                          arguments: {
                            'property_id': propertyId,
                            'viewing_time': viewingTime,
                          },
                        );
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Tiếp tục'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}