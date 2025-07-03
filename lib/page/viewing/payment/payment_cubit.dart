
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../http/API.dart';
import '../../../model/pay/paymentAccounts.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final API api;

  PaymentCubit(this.api) : super(const PaymentInitial()) {
    fetchAllPayments();
    fetchDefaultPayment();
  }

  static const List<String> paymentMethods = [
    'bank_transfer',
    'credit_card',
    'paypal',
    'momo',
    'zalopay',
    'vn_pay',
    'apple_pay',
  ];

  Future<void> fetchAllPayments() async {
    emit(const PaymentLoading());
    try {
      final response = await api.getAllPayment();
      final currentState = state is PaymentSuccess ? state as PaymentSuccess : null;
      emit(PaymentSuccess(
        message: response.message ?? 'Danh sách tài khoản thanh toán',
        selectedAccount: currentState?.selectedAccount,
        allPaymentAccounts: response.data,
        defaultPaymentAccount: currentState?.defaultPaymentAccount,
        selectedPaymentMethod: currentState?.selectedPaymentMethod,
      ));
    } catch (e) {
      final errorMessage = e.toString();
      if (errorMessage.contains('401')) {
        // Chuyển hướng đến màn hình đăng nhập
        emit(const PaymentError(message: 'Phiên đăng nhập hết hạn. Vui lòng đăng nhập lại.'));
      } else {
        emit(PaymentError(message: 'Lỗi khi lấy danh sách tài khoản: $e'));
      }
    }
  }

  Future<void> fetchDefaultPayment() async {
    emit(const PaymentLoading());
    try {
      final defaultAccount = await api.getDefaultPaymentAccount();
      final currentState = state is PaymentSuccess ? state as PaymentSuccess : null;
      emit(PaymentSuccess(
        message: 'Lấy tài khoản mặc định thành công',
        selectedAccount: currentState?.selectedAccount,
        allPaymentAccounts: currentState?.allPaymentAccounts ?? [],
        defaultPaymentAccount: defaultAccount,
        selectedPaymentMethod: currentState?.selectedPaymentMethod,
      ));
    } catch (e) {
      emit(PaymentError(message: 'Lỗi khi lấy tài khoản mặc định: $e'));
    }
  }

  Future<void> addPaymentAccount(PaymentAccount paymentAccount) async {
    emit(const PaymentLoading());
    try {
      final response = await api.addPaymentAccount(paymentAccount);
      if (response['success']) {
        final allPayments = await api.getAllPayment();
        final currentState = state is PaymentSuccess ? state as PaymentSuccess : null;
        emit(PaymentSuccess(
          message: response['message'],
          selectedAccount: currentState?.selectedAccount,
          allPaymentAccounts: allPayments.data,
          defaultPaymentAccount: currentState?.defaultPaymentAccount,
          selectedPaymentMethod: currentState?.selectedPaymentMethod,
        ));
      } else {
        emit(PaymentError(
          message: response['message'],
          errors: response['errors'],
        ));
      }
    } catch (e) {
      emit(PaymentError(message: 'Lỗi khi thêm tài khoản: $e'));
    }
  }

  void updatePaymentMethod(String newValue) {
    if (state is PaymentSuccess) {
      final currentState = state as PaymentSuccess;
      emit(currentState.copyWith(selectedPaymentMethod: newValue));
    } else {
      emit(PaymentSuccess(
        message: 'Phương thức thanh toán đã được chọn',
        selectedAccount: null,
        allPaymentAccounts: [],
        defaultPaymentAccount: null,
        selectedPaymentMethod: newValue,
      ));
    }
  }

  void selectPaymentAccount(PaymentAccount account) {
    if (state is PaymentSuccess) {
      final currentState = state as PaymentSuccess;
      emit(currentState.copyWith(selectedAccount: account));
    }
  }
}