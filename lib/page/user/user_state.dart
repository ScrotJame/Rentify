part of 'user_cubit.dart';

class UserState {
  final User? userCb;
  final bool isLoading;
  final String? error;

//<editor-fold desc="Data Methods">
  const UserState({
    this.userCb,
     this.isLoading=false,
    this.error,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserState &&
          runtimeType == other.runtimeType &&
          userCb == other.userCb &&
          isLoading == other.isLoading &&
          error == other.error);

  @override
  int get hashCode => userCb.hashCode ^ isLoading.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'UserState{' +
        ' userCb: $userCb,' +
        ' isLoading: $isLoading,' +
        ' error: $error,' +
        '}';
  }

  UserState copyWith({
    User? userCb,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      userCb: userCb ?? this.userCb,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userCb': this.userCb,
      'isLoading': this.isLoading,
      'error': this.error,
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      userCb: map['userCb'] as User,
      isLoading: map['isLoading'] as bool,
      error: map['error'] as String,
    );
  }

//</editor-fold>
}

