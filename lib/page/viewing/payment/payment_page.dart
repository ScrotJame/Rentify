import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_cubit.dart';
import '../../../http/API.dart';
import '../../../model/pay/paymentAccounts.dart';

class PaymentPage extends StatelessWidget {
  static const String route = 'payment';
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(context.read<API>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thanh toán'),
        ),
        body: const BodyPage(),
      ),
    );
  }
}

class BodyPage extends StatelessWidget {
  const BodyPage({super.key});

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
                            onTap: (){
                              print("Thay doi dl");
                            },
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
              ElevatedButton(
                onPressed: () {
                  final paymentCubit = context.read<PaymentCubit>();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (bottomSheetContext) => BlocProvider.value(
                      value: paymentCubit,
                      child: const AddPayment(),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.black54, size: 15),
                    SizedBox(width: 10),
                    Text(
                      "Thêm tài khoản thanh toán",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _paymentCvvController = TextEditingController();
  final _paymentEndDateController = TextEditingController();

  final List<String> paymentMethods = [
    "bank_transfer",
    "credit_card",
    "paypal",
    "momo",
    "zalopay",
    "vn pay",
    "apple pay",
  ];
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: paymentMethods.map((method) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(method.toUpperCase()),
                      selected: selectedPaymentMethod == method,
                      onSelected: (selected) {
                        setState(() {
                          selectedPaymentMethod = selected ? method : null;
                        });
                      },
                      selectedColor: Colors.blue, // Màu xanh khi được chọn
                      labelStyle: TextStyle(
                        color: selectedPaymentMethod == method ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _accountNameController,
            decoration: const InputDecoration(
              labelText: 'Tên tài khoản',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.account_circle),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _accountNumberController,
            decoration: const InputDecoration(
              labelText: 'Số thẻ',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.lock),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _paymentEndDateController,
                  decoration: const InputDecoration(
                    labelText: ' Ngày hết hạn',
                    border: OutlineInputBorder(),
                    hintText: 'MM/YY',
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  keyboardType: TextInputType.datetime,
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: _paymentCvvController,
                  decoration: const InputDecoration(
                    labelText: ' CVV',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccess) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: selectedPaymentMethod == null
                    ? null
                    : () {
                  final paymentAccount = PaymentAccount(
                    accountNumber: _accountNumberController.text,
                    accountName: _accountNameController.text,
                    paymentMethod: selectedPaymentMethod!,
                    cvv: _paymentCvvController.text,
                    expirationDate: _paymentEndDateController.text,
                    isDefault: true,
                  );
                  context.read<PaymentCubit>().addPaymentAccount(paymentAccount);
                },
                child: const Text('Thêm'),
              );
            },
          ),
        ],
      ),
    );
  }
}