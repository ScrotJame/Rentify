part of 'payment_cubit.dart';

class PaymentState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final Map<String, dynamic>? addPayData;
  final String? message;

//<editor-fold desc="Data Methods">
  const PaymentState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.addPayData,
    this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isSuccess == other.isSuccess &&
          error == other.error &&
          addPayData == other.addPayData &&
          message == other.message);

  @override
  int get hashCode =>
      isLoading.hashCode ^
      isSuccess.hashCode ^
      error.hashCode ^
      addPayData.hashCode ^
      message.hashCode;

  @override
  String toString() {
    return 'PaymentState{' +
        ' isLoading: $isLoading,' +
        ' isSuccess: $isSuccess,' +
        ' error: $error,' +
        ' addPayData: $addPayData,' +
        ' message: $message,' +
        '}';
  }

  PaymentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    Map<String, dynamic>? addPayData,
    String? message,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      addPayData: addPayData ?? this.addPayData,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLoading': this.isLoading,
      'isSuccess': this.isSuccess,
      'error': this.error,
      'addPayData': this.addPayData,
      'message': this.message,
    };
  }

  factory PaymentState.fromMap(Map<String, dynamic> map) {
    return PaymentState(
      isLoading: map['isLoading'] as bool,
      isSuccess: map['isSuccess'] as bool,
      error: map['error'] as String,
      addPayData: map['addPayData'] as Map<String, dynamic>,
      message: map['message'] as String,
    );
  }

//</editor-fold>
}

