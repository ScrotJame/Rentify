import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/model/propertities.dart';
import '../search/search_cubit.dart';
import 'package:rentify/widget/Properties_list.dart'; // File chứa PropertyList
import 'package:rentify/page/detail/detailpage.dart';

class ResultPage extends StatelessWidget {
  static const String route = 'result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<SearchCubit>().navigateToSearch();
            Navigator.pop(context); // Quay lại SearchPage
          },
        ),
      ),
      // body: BlocBuilder<SearchCubit, SearchState>(
      //   builder: (context, state) {
      //     if (state.isLoading) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (state.error != null) {
      //       return Center(child: Text('Lỗi: ${state.error}'));
      //     }
      //     // Lấy danh sách id từ properties (giả sử bạn muốn giữ nguyên logic điều hướng với id)
      //     // final properties = state.properties;
      //     // return PropertyList(properties: properties);
      //
      //   },
      // ),
    );
  }
}