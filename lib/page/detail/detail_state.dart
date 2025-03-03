part of 'detail_cubit.dart';

 class DetailState {
   final DetailProperty? property;
   final bool isLoading;
   final String? error;

  //<editor-fold desc="Data Methods">
   const DetailState({
    this.property,
    required this.isLoading,
    this.error,
  });

   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailState &&
          runtimeType == other.runtimeType &&
          property == other.property &&
          isLoading == other.isLoading &&
          error == other.error);

   @override
  int get hashCode => property.hashCode ^ isLoading.hashCode ^ error.hashCode;

   @override
  String toString() {
    return 'DetailState{' +
        ' property: $property,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

   DetailState copyWith({
    DetailProperty? property,
    bool? isLoading,
    String? error,
  }) {
    return DetailState(
      property: property ?? this.property,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'property': this.property,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory DetailState.fromMap(Map<String, dynamic> map) {
    return DetailState(
      property: map['property'] as DetailProperty,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

  //</editor-fold>
}


