import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../date_cubit.dart'; // Giả sử DateCubit đã được định nghĩa

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DateCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Thanh toán'),
        ),
        body: BodyPage(),
      ),
    );
  }
}

class BodyPage extends StatefulWidget {
  BodyPage({super.key});

  @override
  _BodyPageState createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
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
          const Text(
            "Chọn phương thức thanh toán",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length + 1,
              itemBuilder: (context, index) {
                if (index == paymentMethods.length) {
                  // Mục "Thêm phương thức thanh toán"
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.add, color: Colors.black54),
                      title: const Text(
                        'Thêm phương thức thanh toán',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        _showAddPaymentSheet(context);
                      },
                    ),
                  );
                }

                // Các phương thức thanh toán hiện có
                final method = paymentMethods[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      "${method['type']} - ${method['last4']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedMethodIndex == index
                            ? Colors.green
                            : Colors.black,
                      ),
                    ),
                    trailing: selectedMethodIndex == index
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedMethodIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: selectedMethodIndex != null
                ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Bạn đã chọn ${paymentMethods[selectedMethodIndex!]['type']}",
                  ),
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

  void _showAddPaymentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _addPayment(context),
    );
  }

  Widget _addPayment(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thêm tài khoản thanh toán',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Số tài khoản',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Tên tài khoản',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phương thức thanh toán',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút "Thêm"
                      Navigator.pop(context); // Đóng sheet sau khi thêm
                    },
                    child: const Text('Thêm'),
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