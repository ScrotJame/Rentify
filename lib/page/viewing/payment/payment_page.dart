import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../date_cubit.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: BodyPage(),
      ),
    );
  }
}

class BodyPage extends StatelessWidget {
   BodyPage({super.key});
  final List<Map<String, String>> paymentMethods = [
    {'type': 'Visa', 'last4': '1234'},
    {'type': 'MasterCard', 'last4': '5678'},
    {'type': 'MoMo', 'last4': 'N/A'},
  ];
   int? selectedMethodIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Chọn phương thức thanh toán",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.payment,
                      color: selectedMethodIndex == index
                          ? Colors.green
                          : Colors.black54,
                    ),
                    title: Text("${method['type']} - ${method['last4']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedMethodIndex == index
                                ? Colors.green
                                : Colors.black)),
                    trailing: selectedMethodIndex == index
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedMethodIndex != null
                ? () {
              // Xử lý khi chọn phương thức thành công
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Bạn đã chọn ${paymentMethods[selectedMethodIndex!]['type']}"),
                ),
              );
            }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor:
              selectedMethodIndex != null ? Colors.red : Colors.grey,
            ),
            child: const Text(
              "Đồng ý",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),

    );
  }
}
