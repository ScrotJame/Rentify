class Login {
  final String username;
  final String password;

//<editor-fold desc="Data Methods">
  const Login({
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Login && runtimeType == other.runtimeType && username == other.username && password == other.password);

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'Login{' + ' username: $username,' + ' password: $password,' + '}';
  }

  Login copyWith({
    String? username,
    String? password,
  }) {
    return Login(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }

  factory Login.fromMap(Map<String, dynamic> map) {
    return Login(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
