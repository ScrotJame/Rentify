import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../common/enum/load_status.dart';
import '../../model/login.dart';
import '../../http/API.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final API api;

  LoginCubit(this.api) : super(LoginState.initial());

  Future<void> login(String username, String password) async {
    print('LoginCubit: Starting login with username: $username');
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await api.checkLogin(username, password);
      print('LoginCubit: API response: $response');

      if (response.containsKey('token') && response['token'] != null) {
        print('LoginCubit: Emitting authenticated state');
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          token: response['token'],
          message: response['message'] ?? "Login successful",
        ));
      } else {
        print('LoginCubit: No token found in response');
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: response['message'] ?? "Login failed",
        ));
      }
    } catch (e) {
      print('LoginCubit: Error: $e');
      emit(state.copyWith(
        isLoading: false,
        error: "An error occurred: $e",
      ));
    }
  }

  Future<void> register(String username,  String password, String email) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await api.register(username,  password, email);
      final response = await api.checkLogin(username, password);

      if (response.containsKey('token') && response['token'] != null) {
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          token: response['token'],
          message: response['message'] ?? "Registration successful",
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isAuthenticated: false,
          error: response['message'] ?? "Registration failed",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "An error occurred: $e",
      ));
    }
  }
}
