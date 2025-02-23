import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rentify/viewmodel/home_page_modelview.dart';
import 'package:rentify/page/detail/amentity_item.dart';

class AmenitiesPage extends StatefulWidget {
  final int propertyId; // Nhận ID của bất động sản
  const AmenitiesPage({super.key, required this.propertyId});

  @override
  State<AmenitiesPage> createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
  @override
  void initState() {
    super.initState();
    // Gọi fetchPropertyDetail khi widget được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PropertyViewModel>(context, listen: false)
          .fetchAmentitiesProperty(widget.propertyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PropertyViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text('Lỗi: ${viewModel.errorMessage}'));
          } else if (viewModel.selectedProperty == null) {
            return const Center(child: Text('Không có dữ liệu'));
          } else {
            return ListView(
              children: viewModel.selectedProperty!.amenities.map((amenity) {
                return AmenityItem(text: amenity);
              }).toList(),
            );
          }
        },
      ),
    );
  }
}