import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/propertities.dart';
import 'date_cubit.dart';

class BookingWidget extends StatelessWidget {
  final DetailProperty property;

  const BookingWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocProvider(
        create: (context) => DateCubit(),
        child: DraggableScrollableSheet(
          initialChildSize: 0.7, // Lúc đầu chiếm 50% màn hình
          minChildSize: 0.5, // Giới hạn nhỏ nhất là 50%
          maxChildSize: 1, // Giới hạn lớn nhất là 70%
          builder: (context, scrollController) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints( // Giới hạn chiều cao max
                    ),
                    child: BodyContain(property: property),
                  ),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}

class BodyContain extends StatelessWidget {
  final DetailProperty property;

  const BodyContain({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${property.id}"),
          Text(
            'Đặt phòng: ${property.title}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Giá: ${double.parse(property.price) / 1000000} triệu/tháng',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          BlocBuilder<DateCubit, DateTime?>(
            builder: (context, selectedDate) {
              return TextField(
                controller: TextEditingController(
                  text: selectedDate != null ? selectedDate.toString().split(' ')[0] : '',
                ),
                decoration: InputDecoration(
                  labelText: 'Date',
                  icon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  context.read<DateCubit>().selectDate(context);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Ngày kết thúc',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 26),
          CachedNetworkImage(
            imageUrl: property.user.avatar.startsWith('http')
                ? property.user.avatar
                : 'http://192.168.1.2:8000/api/${property.user.avatar}', // Fallback nếu không phải URL
            width: 75,
            height: 75,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đặt phòng thành công!')),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Xác nhận đặt phòng',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}