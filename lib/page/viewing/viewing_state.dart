part of 'viewing_cubit.dart';

class ViewngState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final Map<String, dynamic>? bookingData;
  final List<PaymentAccount> paymentAccounts;
  final PaymentAccount? selectedAccount;

  ViewngState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.bookingData,
    this.paymentAccounts = const [],
    this.selectedAccount,
  });

  ViewngState.initial()
      : isLoading = false,
        isSuccess = false,
        error = null,
        bookingData = null,
        paymentAccounts = const [],
        selectedAccount = null;

  ViewngState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    Map<String, dynamic>? bookingData,
    List<PaymentAccount>? paymentAccounts,
    PaymentAccount? selectedAccount,
  }) {
    return ViewngState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      bookingData: bookingData ?? this.bookingData,
      paymentAccounts: paymentAccounts ?? this.paymentAccounts,
      selectedAccount: selectedAccount ?? this.selectedAccount,
    );
  }
}