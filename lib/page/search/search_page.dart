import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/search/search_cubit.dart';

import '../result/result_page.dart';

class Search_Page extends StatelessWidget {
  static const String route = 'search';

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  void _handleSearch(BuildContext context) {
    final query = _locationController.text.trim(); // Lấy và cắt khoảng trắng
    if (query.isNotEmpty) {
      // Cập nhật từ khóa trong SearchCubit
      context.read<SearchCubit>().updateQuery(query);
      // Điều hướng đến ResultPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultPage()),
      );
    } else {
      // Hiển thị thông báo nếu từ khóa rỗng
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng nhập từ khóa tìm kiếm')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm bất động sản'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Quay lại PageMain
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Nhập nơi ở bạn muốn tìm',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleSearch(context), // Truyền context vào hàm
                child: const Text('Tìm kiếm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}