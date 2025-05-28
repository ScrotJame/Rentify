import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_manager_state.dart';

class RoomManagerCubit extends Cubit<RoomManagerState> {
  RoomManagerCubit() : super(RoomManagerInitial());
}
