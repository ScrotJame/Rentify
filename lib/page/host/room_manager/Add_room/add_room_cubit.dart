import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../http/API.dart';
import '../../../../model/amenities.dart';
import '../../../../model/propertities.dart';

part 'add_room_state.dart';

class AddRoomCubit extends Cubit<AddRoomState> {
  final API api;
  AddRoomCubit(this.api) : super(PropertyInitial());

  Future<void> loadAmenities() async {
    emit(const PropertyLoading());
    try {
      final amenities = await api.getAmenities();
      emit(AmenitiesLoadSuccess(
        availableAmenities: amenities,
        selectedAmenities: [],
        restroomType: 'shared',
        propertyType: 'apartment',
      ));
    } catch (e) {
      emit(PropertyError(message: 'Lỗi khi tải danh sách tiện ích: $e'));
    }
  }

  void toggleAmenity(AllAmenity amenity) {
    final currentState = state;
    if (currentState is AmenitiesLoadSuccess) {
      final newSelected = List<AllAmenity>.from(currentState.selectedAmenities);
      if (newSelected.any((a) => a.id == amenity.id)) {
        newSelected.removeWhere((a) => a.id == amenity.id);
      } else {
        newSelected.add(amenity);
      }
      emit(currentState.copyWith(selectedAmenities: newSelected));
    }
  }

  void setRestroomType(String type) {
    final currentState = state;
    if (currentState is AmenitiesLoadSuccess) {
      emit(currentState.copyWith(restroomType: type));
    }
  }
  void setPropertyType(String type) {
    final currentState = state;
    if (currentState is AmenitiesLoadSuccess) {
      emit(currentState.copyWith(propertyType: type));
    }
  }

  Future<void> addRoom(Property property, List<File> imageFiles, List<AllAmenity> amenities) async {
    emit(PropertyLoading());
    try {
      final response = await api.addProperty(property, imageFiles, amenities);
      if (response['success'] == true) {
        emit(PropertySuccess(
          message: response['message'] ?? 'Property created successfully',
          property: response['data'] ?? {},
        ));
      } else {
        emit(PropertyError(
          message: response['message'] ?? 'Failed to create property',
          errors: response['errors'],
        ));
      }
    } catch (e) {
      emit(PropertyError(message: 'Lỗi khi thêm tài khoản: $e'));
    }
  }
}