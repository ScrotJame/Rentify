import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/propertities.dart';
import '../detail/detailpage.dart';
import 'favorite_cubit.dart';

class FavoritePage extends StatelessWidget {
  static const route = '/favorites';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoriteBody(),
    );
  }
}

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteListLoaded) {
          final allProperties = state.favorites
              .expand((favorite) => favorite.data)
              .toList();
          if (state.favorites.isEmpty) {
            return const Center(child: Text('Không có bất động sản nào trong danh sách yêu thích'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: allProperties.length,
            itemBuilder: (context, index) {
              final property = allProperties[index];
              return FavoriteCard(property: property);
            },
          );
        } else if (state is FavoriteError) {
          return const Center(child: Text('Hãy chọn phòng bạn thích'));
        }
        return const Center(child: Text('Nhấn để tải danh sách yêu thích'));
      },
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final AllProperty property;

  const FavoriteCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (property.id != null) {
          print('Navigating with propertyId: ${property.id}');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(id: property.id),
            ),
          );
        } else {
          print('Invalid propertyId: Null id');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy ID bất động sản')),
          );
        }
      },
      child: Stack(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: property.image.isNotEmpty ? property.image[0].imageUrl : '',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    property.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${property.price} VND",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          // Thêm nút xóa yêu thích trực tiếp từ card
          Positioned(
            top: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  context.read<FavoriteCubit>().toggleFavorite(property.id);
                },
                child: const Icon(Icons.favorite, color: Colors.red, size: 26),

              ),
            ),
          ),
        ],
      ),
    );
  }
}