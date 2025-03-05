part of 'moreamenities_cubit.dart';

 class MoreamenitiesState {
   final List<Amenity> amenities;
   final bool isLoading;
   final String? error;

  //<editor-fold desc="Data Methods">
   const MoreamenitiesState({
    required this.amenities,
    this.isLoading= false,
    this.error,
  });

   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoreamenitiesState &&
          runtimeType == other.runtimeType &&
          amenities == other.amenities &&
          isLoading == other.isLoading &&
          error == other.error);

   @override
  int get hashCode => amenities.hashCode ^ isLoading.hashCode ^ error.hashCode;

   @override
  String toString() {
    return 'MoreamenitiesState{' +
        ' amenities: $amenities,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

   MoreamenitiesState copyWith({
    List<Amenity>? amenities,
    bool? isLoading,
    String? error,
  }) {
    return MoreamenitiesState(
      amenities: amenities ?? this.amenities,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'amenities': this.amenities,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory MoreamenitiesState.fromMap(Map<String, dynamic> map) {
    return MoreamenitiesState(
      amenities: map['amenities'] as List<Amenity>,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

  //</editor-fold>
}
