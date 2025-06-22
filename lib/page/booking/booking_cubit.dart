import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<bool> {
  BookingCubit() : super(false);
  void showSheet() => emit(true);
  void hideSheet() => emit(false);
}
