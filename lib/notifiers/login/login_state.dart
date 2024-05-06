import 'package:suuq_iibiye/models/user_model.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {
  final String email;
  final String password;
  final bool isPasswordHidden;

  LoginInitialState({
    this.email = "",
    this.password = "",
    this.isPasswordHidden = true,
  });

  LoginInitialState copyWith({
    String? email,
    String? password,
    bool? isPasswordHidden,
  }) {
    return LoginInitialState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }
}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final UserModel user;

  const LoginSuccessState(this.user);
}

class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState(this.errorMessage);
}
