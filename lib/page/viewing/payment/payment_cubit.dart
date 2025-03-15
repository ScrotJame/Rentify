import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../http/API.dart';
import '../../../model/pay/paymentAccounts.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final API api;
  PaymentCubit(this.api) : super(PaymentState(isLoading: false, isSuccess: false));
  Future<void> addPaymentAccount(PaymentAccount paymentAccount) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await api.addPaymentAccount(
        paymentAccount
      );
      emit(state.copyWith(isLoading: false,
      isSuccess: true,
      error: null,
          addPayData: response['data'],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),)
      );
  }
 }
}
