import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguyen_ngoc_thang_nexlab/repository/auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<UsernameChanged>(_onUsernameChange);
    on<PasswordChanged>(_onPasswordChange);
    on<ObscuredPasswordChanged>(_onObscuredPasswordChange);
    on<Submitted>(_onSubmit);
  }

  final AuthRepository _authRepo = AuthRepositoryImpl();

  void _onUsernameChange(UsernameChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChange(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onObscuredPasswordChange(
    ObscuredPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscuredPassword: !state.obscuredPassword));
  }

  Future<void> _onSubmit(Submitted event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));

      final response = await _authRepo.signIn(
        username: state.username,
        password: state.password,
      );

      if (!response) {
        throw Exception('Login failed');
      }

      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Failed to login. Please try again later.',
        ),
      );
    }
  }
}
