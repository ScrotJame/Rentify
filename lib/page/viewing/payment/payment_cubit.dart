
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../http/API.dart';
import '../../../model/pay/paymentAccounts.dart';
import 'package:flutter/foundation.dart' show listEquals;
import '../../../model/pay/paymentAccounts.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final API api;

  PaymentCubit(this.api) : super(const PaymentInitial()) {
    fetchAllPayments();
  }

  Future<void> fetchAllPayments() async {
    emit(const PaymentLoading());

    try {
      final response = await api.getAllPayment();
      emit(PaymentSuccess(
        message: response.message ?? 'Danh sách tài khoản thanh toán',
        paymentAccount: null, // Không có tài khoản cụ thể
        allpaymentAccounts: response.data,
      ));
    } catch (e) {
      emit(PaymentError(
        message: 'Lỗi khi lấy danh sách tài khoản: $e',
        errors: null,
      ));
    }
  }

  Future<void> addPaymentAccount(PaymentAccount paymentAccount) async {
    emit(const PaymentLoading());

    try {
      final response = await api.addPaymentAccount(paymentAccount);
      if (response['success']) {
        final allPayments = await api.getAllPayment(); // Lấy lại danh sách
        emit(PaymentSuccess(
          message: response['message'],
          paymentAccount: response['data'] as PaymentAccount, // Tài khoản vừa thêm
          allpaymentAccounts: allPayments.data,
        ));
      } else {
        emit(PaymentError(
          message: response['message'],
          errors: response['errors'],
        ));
      }
    } catch (e) {
      emit(PaymentError(
        message: 'Lỗi khi thêm tài khoản: $e',
        errors: null,
      ));
    }
  }
}