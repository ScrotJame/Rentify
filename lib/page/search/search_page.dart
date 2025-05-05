import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentify/page/search/search_cubit.dart';
import '../result/result_page.dart';

class SearchPage extends StatefulWidget {
  static const String route = 'Search_Page';

  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  int? _selectedBedroom;
  int? _selectedBathroom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    labelText: 'Nhập từ khóa',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<SearchCubit>().updateQuery(value);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int?>(
                        value: _selectedBedroom,
                        onChanged: (value) {
                          setState(() {
                            _selectedBedroom = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Số người',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text('Tất cả'),
                          ),
                          ...List.generate(6, (index) => index).map((number) {
                            return DropdownMenuItem<int?>(
                              value: number,
                              child: Text('$number'),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<int?>(
                        value: _selectedBathroom,
                        onChanged: (value) {
                          setState(() {
                            _selectedBathroom = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Số phòng',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text('Tất cả'),
                          ),
                          ...List.generate(6, (index) => index).map((number) {
                            return DropdownMenuItem<int?>(
                              value: number,
                              child: Text('$number'),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      context.read<SearchCubit>().navigateToResult(
                        _controller.text,
                        Tenant: _selectedBedroom,
                        Rooms: _selectedBathroom,
                      );
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