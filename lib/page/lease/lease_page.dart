import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rentify/page/lease/lease_cubit.dart';

import '../../http/API.dart';

class LeasePage extends StatelessWidget {
  static const String route='/house';
  const LeasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => LeaseCubit(context.read<API>())..fetchLease(),
  child: Scaffold(
    body: LeaseBody(),
    ),
);
  }
}

class LeaseBody extends StatelessWidget {
  const LeaseBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaseCubit, LeaseState>(
      builder: (context, state) {
        if (state is LeaseLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeaseSuccess) {
          if (state.viewings.isEmpty) {
            return const Center(child: Text('Không có đặt phòng nào'));
          }
           return ListView.builder(
            itemCount: state.viewings.length,
            itemBuilder: (context, index) {
              final viewing = state.viewings[index];
              // Định dạng viewingTime
              final formattedTime = DateFormat('dd/MM/yyyy').format(viewing.viewingTime);
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: viewing.imageUrl,
                      width: 75,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
                    ),
                  ),
                  title: Text(
                    viewing.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Thời gian xem: $formattedTime'),
                      const SizedBox(height: 4),
                      Text(
                        'Trạng thái: ${viewing.status}',
                        style: TextStyle(
                          color: viewing.status == 'pending' ? Colors.orange : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã nhấn vào đặt phòng ID: ${viewing.id}')),
                    );
                  },
                ),
              );
            },
          );
        } else if (state is LeaseError) {
          return Center(child: Text('Bạn chưa đặt phòng'));
        } else {
          return const Center(child: Text('Chưa có dữ liệu'));
        }
      },
    );
  }
}
