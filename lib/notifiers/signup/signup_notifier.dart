import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/notifiers/signup/signup_state.dart';
import 'package:suuq_iibiye/services/auth_service.dart';
import 'package:suuq_iibiye/utils/firebase_exceptions.dart';
import 'package:suuq_iibiye/utils/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'signup_notifier.g.dart';

@riverpod
class SignupNotifier extends _$SignupNotifier {
  @override
  SignupState build() {
    return SignupStateInitial();
  }

  void onBusinessNameChanged(String? businessName) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(businessName: businessName);
  }

  void onEmailChanged(String? email) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(email: email);
  }
    void onPhoneNumberChanged(String? phoneNumber) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(phoneNumber: phoneNumber);
  }

  void onPasswordChanged(String? password) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(password: password);
  }

  void onRePasswordChanged(String? rePassword) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(rePassword: rePassword);
  }

  void onIsAgreedChanged(bool? isAgreed) {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isAgreed: isAgreed);
  }

  void onisPasswordHiddenChanged() {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isPasswordHidden: !lastState.isPasswordHidden);
  }

  void onisRePasswordHiddenChanged() {
    var lastState = state as SignupStateInitial;
    state =
        lastState.copyWith(isRePasswordHidden: !lastState.isRePasswordHidden);
  }

  void onSignupPressed(AppLocalizations localizations) async {
    var lastState = state as SignupStateInitial;
    state = lastState.copyWith(isButtonLoading: true);
    try {
      final authService = AuthService();
      state = SignupStateLoading();
      await authService.signup(
        lastState.businessName,
        lastState.phoneNumber,
        lastState.email,
        lastState.password,
        localizations,
      );
      state = SignupStateSuccess();
    } on FirebaseAuthException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e, localizations);
    } catch (e) {
      toastInfo("unknown error $e");
    }
  }
}
