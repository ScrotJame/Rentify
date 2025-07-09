import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../http/API.dart';
import '../../../model/propertities.dart';

part 'room_manager_state.dart';

class RoomManagerCubit extends Cubit<RoomManagerState> {
  final API api;
  String currentStatus = 'all';
  RoomManagerCubit(this.api) : super(RoomManagerInitial());

  Future<void> fetchAllPropertiesByOwner({String status = 'all'}) async {
    currentStatus = status;
    emit(RoomManagerLoading());
    try {
      final properties = await api.getAllPropertyByOwner(status: status);
      emit(RoomManagerLoaded(properties));
    } catch (e) {
      emit(PropertyOwnerError('Lỗi khi tải danh sách bất động sản: $e'));
    }
  }

}
