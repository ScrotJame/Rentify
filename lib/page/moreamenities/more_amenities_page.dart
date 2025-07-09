import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentify/page/moreamenities/moreamenities_cubit.dart';
import '../../http/API.dart';

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
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }
        if (state.amenities == null) {
          return const Center(child: Text('Không tìm thấy bất động sản'));
        }
        final property = state.amenities!;
    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nơi này có",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 8),
            ...(state.amenities ?? []).map((amenity) {
              if (amenity == null) return const SizedBox.shrink();
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
                      placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      amenity.nameAmenities ?? 'Không có tên',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  },
);
  }
}
