part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class UsernameChanged extends LoginEvent {
  final String username;
  UsernameChanged({required this.username});
  @override
  List<Object> get props => [username];
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class ObscuredPasswordChanged extends LoginEvent {
  ObscuredPasswordChanged();
  @override
  List<Object> get props => [];
}

class Submitted extends LoginEvent {
  Submitted();
  @override
  List<Object> get props => [];
}
