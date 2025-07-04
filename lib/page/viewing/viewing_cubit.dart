import 'package:flutter_bloc/flutter_bloc.dart';
import '../../http/API.dart';
import '../../model/pay/paymentAccounts.dart';

part 'viewing_state.dart';

class ViewngCubit extends Cubit<ViewngState> {
  final API api;
  ViewngCubit(this.api) : super(ViewngState(isLoading: false, isSuccess: false));

  Future<void> fetchPaymentAccounts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final allPayment = await api.getAllPayment();
      emit(state.copyWith(
        isLoading: false,
        paymentAccounts: allPayment.data,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void selectPaymentAccount(PaymentAccount account) {
    emit(state.copyWith(selectedAccount: account));
  }

  Future<void> addBooking(int propertyId, String viewingTime,int paymentId, double amount) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final response = await api.addBooking(
          propertyId, viewingTime, paymentId, amount
      );
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        error: null,
        bookingData: response['data'],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        error: e.toString(),
      ));
    }
  }
}