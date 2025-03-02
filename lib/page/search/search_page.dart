import 'package:flutter/material.dart';

class _SearchPage extends StatelessWidget {
  static const String router ='/search';

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  void _handleSearch() {
    print("Tìm kiếm với: Vị trí: \${locationController.text}, ");
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSearch,
              child:  Text('Tìm kiếm'),
            ),
          ),
        ],
      ),
    );
  }
}