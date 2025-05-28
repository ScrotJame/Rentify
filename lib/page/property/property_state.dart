part of 'property_cubit.dart';

class PropertyState {
  final List<AllProperty> properties;
  final List<AllPropertyByOwner> propertiesByOwner;
  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  const PropertyState({
    required this.properties,
    required this.propertiesByOwner,
    required this.isLoading,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertyState &&
          runtimeType == other.runtimeType &&
          properties == other.properties &&
          isLoading == other.isLoading &&
          error == other.error);

  @override
  int get hashCode => properties.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'PropertyState{' +
        ' properties: $properties,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  PropertyState copyWith({
    List<AllProperty>? properties,
    List<AllPropertyByOwner>? propertiesByOwner,
    bool? isLoading,
    String? error,
  }) {
    return PropertyState(
      properties: properties ?? this.properties,
      propertiesByOwner: propertiesByOwner ?? this.propertiesByOwner,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'properties': this.properties,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory PropertyState.fromMap(Map<String, dynamic> map) {
    return PropertyState(
      properties: map['properties'] as List<AllProperty>,
      propertiesByOwner: map['propertiesByOwner'] as List<AllPropertyByOwner>,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}

