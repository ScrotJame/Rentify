import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import '../../http/API.dart';
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

          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              final property = state.result[index];
              // Giả sử state.result là List<ResultProperty>
              return AirbnbExploreItem2.fromResultProperty(property);
            },
          );
        },
      ),
    );
  }
}