part of 'add_room_cubit.dart';
enum FormStatus { available, rented, pending, failure }

abstract class AddRoomState extends Equatable {
  const AddRoomState();

  @override
  List<Object?> get props => [];
}

class PropertyInitial extends AddRoomState {
  const PropertyInitial();
}

class PropertyLoading extends AddRoomState {
  const PropertyLoading();
}

class PropertySuccess extends AddRoomState {
  final String message;
  final Map<String, dynamic> property;

  const PropertySuccess({
    required this.message,
    required this.property,
  });

  PropertySuccess copyWith({
    String? message,
    Map<String, dynamic>? property,
  }) {
    return PropertySuccess(
      message: message ?? this.message,
      property: property ?? this.property,
    );
  }

  @override
  List<Object?> get props => [message, property];
}

class AmenitiesLoadSuccess extends AddRoomState {
  final List<AllAmenity> availableAmenities;
  final List<AllAmenity> selectedAmenities;
  final String restroomType;
  final String propertyType;

  const AmenitiesLoadSuccess({
    required this.availableAmenities,
    required this.selectedAmenities,
    this.restroomType = 'shared',
    this.propertyType = 'apartment',
  });

  AmenitiesLoadSuccess copyWith({
    List<AllAmenity>? availableAmenities,
    List<AllAmenity>? selectedAmenities,
    String? restroomType,
    String? propertyType,

  }) {
    return AmenitiesLoadSuccess(
      availableAmenities: availableAmenities ?? this.availableAmenities,
      selectedAmenities: selectedAmenities ?? this.selectedAmenities,
      restroomType: restroomType ?? this.restroomType,
      propertyType: propertyType ?? this.propertyType,
    );
  }

  @override
  List<Object?> get props => [availableAmenities, selectedAmenities, restroomType, propertyType];
}

class PropertyError extends AddRoomState {
  final String message;
  final Map<String, dynamic>? errors;

  const PropertyError({
    required this.message,
    this.errors,
  });

  @override
  List<Object?> get props => [message, errors];
}