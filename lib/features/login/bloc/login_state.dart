part of 'login_bloc.dart';

enum LoginStatus { init, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.init,
    this.username = '',
    this.password = '',
    this.obscuredPassword = true,
    this.errorMessage,
  });

  final LoginStatus status;
  final String username;
  final String password;
  final bool obscuredPassword;
  final String? errorMessage;

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
    bool? obscuredPassword,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      obscuredPassword: obscuredPassword ?? this.obscuredPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    username,
    password,
    obscuredPassword,
    errorMessage,
  ];
}
