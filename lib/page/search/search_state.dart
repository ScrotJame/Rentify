part of 'search_cubit.dart';

class SearchState {
  final String? query;
  final List<ResultProperty> result;
  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  SearchState({
    this.query,
    required this.result,
    required this.isLoading,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchState &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          result == other.result &&
          isLoading == other.isLoading &&
          error == other.error );

  @override
  int get hashCode =>
      query.hashCode ^
      result.hashCode ^
      isLoading.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'SearchState{' +
        ' query: $query,' +
        ' properties: $result,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  SearchState copyWith({
    String? query,
    List<ResultProperty>? result,
    bool? isLoading,
    String? error,
    String? currentPage,
  }) {
    return SearchState(
      query: query ?? this.query,
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      'properties': this.result,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory SearchState.fromMap(Map<String, dynamic> map) {
    return SearchState(
      query: map['query'] as String,
      result: map['properties'] as List<ResultProperty>,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}


