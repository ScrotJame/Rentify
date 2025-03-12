import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../http/API.dart';
import '../../model/viewing.dart';

part 'viewing_state.dart';

class ViewngCubit extends Cubit<ViewngState> {
  final API api;
  ViewngCubit(this.api) : super(ViewngState(isLoading: false, isSuccess: false));
  Future<void> addBooking(int propertyId, String viewingTime) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await api.addBooking(
         propertyId, viewingTime
      );
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        error: null,
        bookingData: response['data'],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      ));
    }
  }
}