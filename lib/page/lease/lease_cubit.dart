import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/viewing.dart';

part 'lease_state.dart';

class LeaseCubit extends Cubit<LeaseState> {
  final API api;
  LeaseCubit(this.api) : super(LeaseInitial());
  Future<void> fetchLease() async {
    emit(LeaseLoading());
    print('Debug: Bắt đầu fetch dữ liệu lịch đặt phòng...');

    try {
      final leases = await api.getLease();
      print('Debug: Dữ liệu nhận được - ${leases.length} bookings');

      if (leases.isEmpty) {
        emit(LeaseSuccess([]));
        print('Debug: Không có lịch đặt phòng nào.');
      } else {
        emit(LeaseSuccess(leases));
      }
    } catch (e) {
      print('Debug: Lỗi khi fetch lịch đặt phòng - $e');
      emit(LeaseError('Lỗi khi lấy dữ liệu lịch đặt phòng.'));
    }
  }

  Future<void> fetchDetailLease(int id) async {
    emit(LeaseLoading());
    try {
      final viewings = await api.getDetailLease(id);
      //emit(LeaseSuccess(viewings));
    } catch (e) {
      emit(LeaseError(e.toString()));
    }
  }
}
