part of 'room_management_cubit.dart';

sealed class RoomManagementState extends Equatable {
  const RoomManagementState();
}

final class RoomManagementInitial extends RoomManagementState {
  @override
  List<Object> get props => [];
}
