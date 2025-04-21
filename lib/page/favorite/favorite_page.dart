import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/favorite.dart';
import '../detail/detailpage.dart';
import 'favorite_cubit.dart';

class FavoritePage extends StatelessWidget {
  static const route = '/favorite';

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const FavoriteBody(),
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
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              final item = state.favorites[index];
              return FavoriteCard(item: item);
            },
          );
        } else if (state is FavoriteError) {
          return Center(child: Text('Lỗi: ${state.error}'));
        }
        return const Center(child: Text('Nhấn để tải danh sách yêu thích'));
      },
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Favorite item;

  const FavoriteCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.data.isNotEmpty && item.data[0].id != null) {
          Navigator.pushNamed(
            context,
            DetailPage.route,
            arguments: item.data[0].id,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Không tìm thấy ID bất động sản')),
          );
        }
      },
      child: Card(
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
                imageUrl: item.data.isNotEmpty ? item.data[0].image[0].imageUrl : '',
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
                item.data[0].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                item.data.isNotEmpty ? "${item.data[0].price} VND" : 'Không có giá',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}