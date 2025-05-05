part of 'search_cubit.dart';

class SearchState {
  final String? query;
  final List<ResultProperty> result;
  final int? totalTenant;
  final int? totalRooms;

  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  SearchState({
    this.query,
    this.totalTenant,
    this.totalRooms,
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
          totalTenant == other.totalTenant &&
          totalRooms == other.totalRooms &&
          result == other.result &&
          isLoading == other.isLoading &&
          error == other.error );

  @override
  int get hashCode =>
      query.hashCode ^
      totalTenant.hashCode ^
      totalRooms.hashCode ^
      result.hashCode ^
      isLoading.hashCode ^
      error.hashCode;

  @override
  String toString() {
    return 'SearchState{' +
        ' query: $query,' +
        ' totalTenant: $totalTenant,' +
        ' totalRooms: $totalRooms,' +
        ' properties: $result,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  SearchState copyWith({
    String? query,
    List<ResultProperty>? result,
    int? totalTenant,
    int? totalRooms,
    bool? isLoading,
    String? error,
    String? currentPage,
  }) {
    return SearchState(
      query: query ?? this.query,
      result: result ?? this.result,
      totalTenant: totalTenant ?? this.totalTenant,
      totalRooms: totalRooms ?? this.totalRooms,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      'properties': this.result,
      'totalTenant': this.totalTenant,
      'totalRooms': this.totalRooms,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory SearchState.fromMap(Map<String, dynamic> map) {
    return SearchState(
      query: map['query'] as String,
      result: map['properties'] as List<ResultProperty>,
      totalTenant: map['totalTenant'] as int,
      totalRooms: map['totalRooms'] as int,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}


