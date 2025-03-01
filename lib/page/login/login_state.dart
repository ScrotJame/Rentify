part of 'login_cubit.dart';

class LoginState {
  final LoadStatus loadStatus;

  const LoginState.init({this.loadStatus = LoadStatus.Init});

//<editor-fold desc="Data Methods">
  const LoginState({
    required this.loadStatus,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is LoginState && runtimeType == other.runtimeType && loadStatus == other.loadStatus);

  @override
  int get hashCode => loadStatus.hashCode;

  @override
  String toString() {
    return 'LoginState{' + ' loadStatus: $loadStatus,' + '}';
  }

  LoginState copyWith({
    LoadStatus? loadStatus,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loadStatus': this.loadStatus,
    };
  }

  factory LoginState.fromMap(Map<String, dynamic> map) {
    return LoginState(
      loadStatus: map['loadStatus'] as LoadStatus,
    );
  }

//</editor-fold>
}
