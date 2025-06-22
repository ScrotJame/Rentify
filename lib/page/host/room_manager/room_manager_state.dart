part of 'room_manager_cubit.dart';

sealed class RoomManagerState extends Equatable {
  const RoomManagerState();
}

final class RoomManagerInitial extends RoomManagerState {
  @override
  List<Object> get props => [];
}

class RoomManagerLoading extends RoomManagerState {
  List<Object?> get props => throw UnimplementedError();
}

class RoomManagerLoaded extends RoomManagerState {
  final List<AllPropertyByOwner> properties;

  const RoomManagerLoaded(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyOwnerError extends RoomManagerState {
  final String message;

  const PropertyOwnerError(this.message);

  @override
  List<Object?> get props => [message];
}