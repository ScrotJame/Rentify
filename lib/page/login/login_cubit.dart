import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../common/enum/load_status.dart';
import '../../model/login.dart';
import '../../http/API.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final API api;

  LoginCubit(this.api) : super(LoginState.init());

  Future<void> checkLogin(Login login) async {
    if (login.username.isEmpty || login.password.isEmpty) {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
      return;
    }

    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.checkLogin(login);
    if (result) {
      emit(state.copyWith(loadStatus: LoadStatus.Done));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }
  Future<void> Register(Login login) async {
    emit(state.copyWith(loadStatus: LoadStatus.Loading));
    var result = await api.checkLogin(login);
    if (result) {
      emit(state.copyWith(loadStatus: LoadStatus.Done));
    } else {
      emit(state.copyWith(loadStatus: LoadStatus.Error));
    }
  }
}
