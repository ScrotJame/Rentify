part of 'payment_cubit.dart';


abstract class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentSuccess extends PaymentState {
  final String message;
  final PaymentAccount? paymentAccount; // Tài khoản cụ thể (nullable)
  final List<PaymentAccount> allpaymentAccounts; // Danh sách tất cả

  const PaymentSuccess({
    required this.message,
    this.paymentAccount,
    required this.allpaymentAccounts,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PaymentSuccess &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              paymentAccount == other.paymentAccount &&
              listEquals(allpaymentAccounts, other.allpaymentAccounts);

  @override
  int get hashCode =>
      message.hashCode ^
      (paymentAccount?.hashCode ?? 0) ^
      allpaymentAccounts.hashCode;
}

class PaymentError extends PaymentState {
  final String message;
  final Map<String, dynamic>? errors;

  const PaymentError({
    required this.message,
    this.errors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PaymentError &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              errors == other.errors;

  @override
  int get hashCode => message.hashCode ^ (errors?.hashCode ?? 0);
}