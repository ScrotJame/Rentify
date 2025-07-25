import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/page/detail/detailpage.dart';
import 'package:rentify/page/item_explore.dart';

import '../page/detail/detail_cubit.dart';
import '../page/favorite/favorite_cubit.dart';

class PropertyList extends StatelessWidget {
  final List<AllProperty> properties;

  const PropertyList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is FavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Container(
        width: 450,
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final property = properties[index];
            return GestureDetector(
              onTap: () {
                if (property.id != null) {
                  context.read<DetailCubit>().fetchPropertyDetail(property.id!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(id: property.id),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID không hợp lệ cho bất động sản này')),
                  );
                }
              },
              key: UniqueKey(),
              child: AirbnbExploreItem2.fromAllProperty(property), // Đảm bảo mỗi widget độc lập
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}

class PropertyByOwnerList extends StatelessWidget {
  final List<AllPropertyByOwner> properties;

  const PropertyByOwnerList({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is FavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return GestureDetector(
            onTap: () {
              if (property.id != null) {
                context.read<DetailCubit>().fetchPropertyDetail(property.id!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(id: property.id),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ID không hợp lệ cho bất động sản này')),
                );
              }
            },
            key: UniqueKey(),
            child: AirbnbExploreItem2.fromAllPropertyByOwner(property),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}