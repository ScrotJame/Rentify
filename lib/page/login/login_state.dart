part of 'login_cubit.dart';

class LoginState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final String? token;
  final String? message;

  factory LoginState.initial() => LoginState(
    isLoading: false,
    isAuthenticated: false,
    token: null,
    message: null,
  );

  const LoginState({
    required this.isLoading,
    required this.isAuthenticated,
    this.error,
    this.token,
    this.message,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    String? token,
    String? message,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      token: token ?? this.token,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'LoginState{isLoading: $isLoading, isAuthenticated: $isAuthenticated, error: $error, token: $token, message: $message}';
  }
}
