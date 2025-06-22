import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import '../widget/color_status.dart';
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
      id: property.id,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Align(
                      alignment: AlignmentDirectional(-0.06, -0.86),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(24),
                        child: Image.network(
                          imageUrl,
                          width: 314.3,
                          height: 168.4,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, size: 50);
                          },
                        ),
                      ),
                    ),
                  ),
                  //if (role != 'owner')
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                //overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              // Địa chỉ
                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (status != null)
                              Container(
                                width: 80,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: getStatusColor(status),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8,2, 8, 5),
                                    child: Text(
                                      '$status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              //Ratting
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    rating.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text('${price.toStringAsFixed(2)} triệu',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
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

