part of 'viewing_cubit.dart';

class ViewngState {
  final Booking? booking;
  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  const ViewngState({
    this.booking,
    required this.isLoading,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViewngState &&
          runtimeType == other.runtimeType &&
          booking == other.booking &&
          isLoading == other.isLoading &&
          error == other.error);

  @override
  int get hashCode => booking.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'ViewngState{' +
        ' booking: $booking,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  ViewngState copyWith({
    Booking? booking,
    bool? isLoading,
    String? error,
  }) {
    return ViewngState(
      booking: booking ?? this.booking,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'booking': this.booking,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory ViewngState.fromMap(Map<String, dynamic> map) {
    return ViewngState(
      booking: map['booking'] as Booking,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}

