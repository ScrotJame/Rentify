part of 'search_cubit.dart';

class SearchState {
  final List<DetailProperty> properties;
  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  const SearchState({
    required this.properties,
    required this.isLoading,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchState &&
          runtimeType == other.runtimeType &&
          properties == other.properties &&
          isLoading == other.isLoading &&
          error == other.error);

  @override
  int get hashCode => properties.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'SearchState{' +
        ' properties: $properties,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  SearchState copyWith({
    List<DetailProperty>? properties,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      properties: properties ?? this.properties,
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

  factory SearchState.fromMap(Map<String, dynamic> map) {
    return SearchState(
      properties: map['properties'] as List<DetailProperty>,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}


