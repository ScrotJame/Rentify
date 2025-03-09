import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/search/search_cubit.dart';

import '../result/result_page.dart';
import 'package:rentify/http/API.dart';


class Search_Page extends StatelessWidget {
  static const String route = 'Search_Page';
  final TextEditingController _controller = TextEditingController();

  Search_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (!state.isLoading && state.error == null && state.result.isNotEmpty) {
              Navigator.pushNamed(context, ResultPage.route);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Nhập từ khóa ',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      context.read<SearchCubit>().navigateToResult(_controller.text);
                    },
                    child: const Text('Tìm kiếm'),
                  ),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}