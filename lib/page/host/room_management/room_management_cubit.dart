import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'room_management_state.dart';

class RoomManagementCubit extends Cubit<RoomManagementState> {
  RoomManagementCubit() : super(RoomManagementInitial());
}
