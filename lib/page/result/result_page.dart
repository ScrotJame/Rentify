import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import '../../http/API.dart';
import '../detail/detail_cubit.dart';
import '../detail/detailpage.dart';
import '../item_explore.dart';
import '../search/search_cubit.dart';

class ResultPage extends StatelessWidget {
  static const String route = 'ResultPage';

  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm: ${context.read<SearchCubit>().state.query ?? ""}'),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Lỗi: ${state.error}'));
          } else if (state.result.isEmpty) {
            return const Center(child: Text('Không tìm thấy bất động sản'));
          }

          return Container(
            width: 450,
            child: ListView.separated(
              padding: EdgeInsets.all(20),
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final property = state.result[index];
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
                  child: AirbnbExploreItem2.fromResultProperty(property),
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
        },
      ),
    );
  }
}