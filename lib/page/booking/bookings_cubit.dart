import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit() : super(BookingsInitial());
}
