part of 'viewing_cubit.dart';

class ViewngState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final Map<String, dynamic>? bookingData;

  ViewngState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.bookingData,
  });

  ViewngState.initial()
      : isLoading = false,
        isSuccess = false,
        error = null,
        bookingData = null;

  ViewngState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    Map<String, dynamic>? bookingData,
  }) {
    return ViewngState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      bookingData: bookingData ?? this.bookingData,
    );
  }
}


