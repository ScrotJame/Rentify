import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import 'package:rentify/page/detail/detailpage.dart';
import 'package:rentify/page/item_explore.dart';

import '../page/detail/detail_cubit.dart';

class PropertyList extends StatelessWidget {
  final List<AllProperty> properties;
  // final List<DetailProperty> property2;

  const PropertyList({ required this.properties});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: ListView.separated(
        padding: EdgeInsets.all(20),
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
          return GestureDetector(
            onTap: () {if (property.id != null) {
              context.read<DetailCubit>().fetchPropertyDetail(property.id!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(id: property.id),
                ),
              );
            } else {
              // Xử lý trường hợp id là null
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('ID không hợp lệ cho bất động sản này')),
              );
            }
            },
            child: AirbnbExploreItem2.fromAllProperty(property), // Sử dụng factory từ AllProperty
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            width: 200,
            height: 10,
          );
        },
      ),
    );
  }
}