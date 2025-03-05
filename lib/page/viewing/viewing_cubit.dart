import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/viewing.dart';

part 'viewing_state.dart';

class ViewngCubit extends Cubit<ViewngState> {
  final API api;
  ViewngCubit(this.api) : super(ViewngState(isLoading: false));
  Future<void> addBooking(int propertyId, int userId, DateTime viewingTime, int id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final booking = Booking(
        propertyId: propertyId,
        userId: userId,
        viewingTime: viewingTime,
        status: 'pending',
        id: id
      );
      final newBooking = await api.addBooking(booking);
      emit(state.copyWith(booking: newBooking, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
