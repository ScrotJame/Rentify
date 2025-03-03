part of 'search_cubit.dart';

class SearchState {
  final String? query;
  final List<DetailProperty> properties;
  final bool isLoading;
  final String? error;
  final String? currentPage;

//<editor-fold desc="Data Methods">
  SearchState({
    this.query,
    required this.properties,
    required this.isLoading,
    this.error,
    this.currentPage='search',
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchState &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          properties == other.properties &&
          isLoading == other.isLoading &&
          error == other.error &&
          currentPage == other.currentPage);

  @override
  int get hashCode =>
      query.hashCode ^
      properties.hashCode ^
      isLoading.hashCode ^
      error.hashCode ^
      currentPage.hashCode;

  @override
  String toString() {
    return 'SearchState{' +
        ' query: $query,' +
        ' properties: $properties,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        ' currentPage: $currentPage,' +
        '}';
  }

  SearchState copyWith({
    String? query,
    List<DetailProperty>? properties,
    bool? isLoading,
    String? error,
    String? currentPage,
  }) {
    return SearchState(
      query: query ?? this.query,
      properties: properties ?? this.properties,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      'properties': this.properties,
      'isLoading': this.isLoading,
      'error': this.error,
      'currentPage': this.currentPage,
    };
  }

  factory SearchState.fromMap(Map<String, dynamic> map) {
    return SearchState(
      query: map['query'] as String,
      properties: map['properties'] as List<DetailProperty>,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
      currentPage: map['currentPage'] as String,
    );
  }

//</editor-fold>
}


