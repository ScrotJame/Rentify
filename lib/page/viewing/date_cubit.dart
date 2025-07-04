import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'date_state.dart';

class DateCubit extends Cubit<DateTime?> {
  DateCubit() : super(null);

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: state ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      context.read<DateCubit>().emit(picked); // Cập nhật trạng thái với ngày mới
    }
  }
}
