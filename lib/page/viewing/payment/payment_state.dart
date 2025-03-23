part of 'payment_cubit.dart';


abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  final String message;
  final PaymentAccount? selectedAccount;
  final List<PaymentAccount> allPaymentAccounts;
  final PaymentAccount? defaultPaymentAccount;
  final String? selectedPaymentMethod;

  const PaymentSuccess({
    required this.message,
    this.selectedAccount,
    required this.allPaymentAccounts,
    this.defaultPaymentAccount,
    this.selectedPaymentMethod,
  });

  PaymentSuccess copyWith({
    String? message,
    PaymentAccount? selectedAccount,
    List<PaymentAccount>? allPaymentAccounts,
    PaymentAccount? defaultPaymentAccount,
    String? selectedPaymentMethod,
  }) {
    return PaymentSuccess(
      message: message ?? this.message,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      allPaymentAccounts: allPaymentAccounts ?? this.allPaymentAccounts,
      defaultPaymentAccount: defaultPaymentAccount ?? this.defaultPaymentAccount,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
    );
  }

  @override
  List<Object?> get props => [
    message,
    selectedAccount,
    allPaymentAccounts,
    defaultPaymentAccount,
    selectedPaymentMethod,
  ];
}

class PaymentError extends PaymentState {
  final String message;
  final Map<String, dynamic>? errors;

  const PaymentError({
    required this.message,
    this.errors,
  });

  @override
  List<Object?> get props => [message, errors];
}