import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import 'favorite/favorite_cubit.dart';

class AirbnbExploreItem2 extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String location;
  final String title;
  final double price;
  final double rating;
  final String? status ;

  const AirbnbExploreItem2({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.location,
    required this.title,
    required this.price,
    required this.rating,
    this.status ,
  }) : super(key: key);

  factory AirbnbExploreItem2.fromAllProperty(AllProperty property) {
    return AirbnbExploreItem2(
      id: property.id!,
      imageUrl: property.image.isNotEmpty
          ? property.image.first.imageUrl
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbniGTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      location: property.location,
      title: property.title,
      price: double.parse(property.price) / 1000000,
      rating: 4.7,
    );
  }

  factory AirbnbExploreItem2.fromResultProperty(ResultProperty property) {
    return AirbnbExploreItem2(
      id: property.id!,
      imageUrl: property.image.isNotEmpty
          ? property.image.first.imageUrl
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbniGTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      location: property.location,
      title: property.title,
      price: double.parse(property.price) / 1000000,
      rating: 4.7,
    );
  }
  factory AirbnbExploreItem2.fromAllPropertyByOwner(AllPropertyByOwner property) {
    return AirbnbExploreItem2(
      id: property.id!,
      imageUrl: property.image.isNotEmpty
          ? property.image.first.imageUrl
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbniGTPGbuIGw19IKId0kGKreJbLPkccOMJ0NFU5A&s',
      location: property.location,
      title: property.title,
      price: double.parse(property.price) / 1000000,
      status: property.status,
      rating: 4.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        bool isFavorite = false;
        if (state is FavoriteListLoaded) {
          isFavorite = state.favorites
              .expand((favorite) => favorite.data)
              .any((item) => item.id == id);
        }

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 50);
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        context.read<FavoriteCubit>().toggleFavorite(id);
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        if (status != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '$status',
                              style: TextStyle(
                                color: getStatusColor(status),
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(location, style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 5),
                    Text('VND ${price.toStringAsFixed(2)} triệu/month',
                        style: TextStyle(color: Colors.red)),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(rating.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Color getStatusColor(String? status) {
  switch (status) {
    case 'available':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'rented':
      return Colors.red;
    default:
      return Colors.grey;
  }
}