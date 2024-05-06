import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/notifiers/login/login_state.dart';
import 'package:suuq_iibiye/services/auth_service.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthService authService = AuthService();
  LoginNotifier() : super(LoginInitialState());

  void onEmailChanged(String? email) {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(email: email);
  }

  void onPasswordChanged(String? password) {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(password: password);
  }

  void onIsPasswordHiddenChanged() {
    var lastState = (state as LoginInitialState);
    state = lastState.copyWith(isPasswordHidden: !lastState.isPasswordHidden);
  }

  void handleLogin() async {
     var lastState = (state as LoginInitialState);
     state = LoginLoadingState();
    try {
      final UserModel? user = await authService.login(lastState.email, lastState.password);
      if(user!=null){
        state = LoginSuccessState(user);
      }else {
        state = LoginFailureState('login failed');
      }
    }finally{
      state = lastState;
    }
    
  }
}

final loginInNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
