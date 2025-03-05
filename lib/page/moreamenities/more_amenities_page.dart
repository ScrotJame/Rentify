import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/morewidget/widText.dart';
import 'package:flutter_svg/svg.dart'; // Đã có
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rentify/page/item_explore.dart';
import 'package:rentify/page/moreamenities/more_amenities_page.dart';
import 'package:rentify/page/moreamenities/moreamenities_cubit.dart';
import '../../../model/propertities.dart';
import '../../widget/booking/booking_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../http/API.dart';
import '../detail/detail_cubit.dart';

class UtilitiesPage extends StatelessWidget {
  final int? id; // Đổi thành required để tránh null
  static const String route = 'detail/amenities';

  const UtilitiesPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreamenitiesCubit(context.read<API>())
        ..fetchAllPropertiesAmenities(id!),
      child: Scaffold(
        appBar: AppBar(),
        body: ListAmenities(id: id),
      ),
    );
  }
}


class ListAmenities extends StatelessWidget {
  final int? id;

  const ListAmenities({super.key, this.id});
  @override
  Widget build(BuildContext context) {
    context.read<MoreamenitiesCubit>().fetchAllPropertiesAmenities(id!);

    return BlocBuilder<MoreamenitiesCubit, MoreamenitiesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }
        if (state.amenities == null) {
          return Center(child: Text('Không tìm thấy bất động sản'));
        }
        final property = state.amenities!;
    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nơi này có",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            SizedBox(height: 8),
            ...(state.amenities ?? []).map((amenity) {
              if (amenity == null) return SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/${amenity.iconAmenities ?? 'default'}.svg',
                      width: 35,
                      height: 35,
                      color: Colors.black,
                      placeholderBuilder: (context) => Icon(Icons.error, color: Colors.red),
                    ),
                    SizedBox(width: 10),
                    Text(
                      amenity.nameAmenities ?? 'Không có tên',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  },
);
  }
}
