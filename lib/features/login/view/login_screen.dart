import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguyen_ngoc_thang_nexlab/components/buttons/buttons.dart';
import 'package:nguyen_ngoc_thang_nexlab/components/inputs/inputs.dart';
import 'package:nguyen_ngoc_thang_nexlab/features/home/view/home_screen.dart';
import 'package:nguyen_ngoc_thang_nexlab/features/login/bloc/login_bloc.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = context.read<LoginBloc>();

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case LoginStatus.init:
              break;
            case LoginStatus.loading:
              break;
            case LoginStatus.success:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Login Successful',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
              break;
            case LoginStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Login Failed',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.pink,
                ),
              );
              break;
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            height: height,
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    spacing: 16,
                    children: <Widget>[
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return InputFormField(
                            label: 'Username',
                            isDisabled: state.status == LoginStatus.loading,
                            onChanged: (value) {
                              loginBloc.add(UsernameChanged(username: value));
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }

                              return null;
                            },
                          );
                        },
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return InputFormField(
                            label: 'Password',
                            obscureText: state.obscuredPassword,
                            isPassword: true,
                            isDisabled: state.status == LoginStatus.loading,
                            onChanged: (value) {
                              loginBloc.add(PasswordChanged(password: value));
                            },
                            onObscureChanged: () {
                              loginBloc.add(ObscuredPasswordChanged());
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              text: 'Login',
                              disabled: state.status == LoginStatus.loading,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                loginBloc.add(Submitted());
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
