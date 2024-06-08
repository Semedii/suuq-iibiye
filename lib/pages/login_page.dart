import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_textfield.dart';
import 'package:suuq_iibiye/notifiers/login/login_notifier.dart';
import 'package:suuq_iibiye/notifiers/login/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_styles.dart';
import 'package:suuq_iibiye/utils/pop_up_message.dart';
import 'package:suuq_iibiye/utils/string_utilities.dart';

import '../components/app_button.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginState = ref.watch(loginInNotifierProvider);
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        bottom: _getAppBarBottom(),
        title: Text(localizations.login),
      ),
      body: mapStateToWidget(context, ref, loginState),
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    WidgetRef ref,
    LoginInitialState loginState,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getEmailField(loginState, localizations, ref),
          _getPasswordField(loginState, localizations, ref),
          _getForgotPasswordText(localizations),
          _getLoginButton(localizations, ref),
          _getSignupButton(localizations, context)
        ],
      ),
    );
  }

  PreferredSize _getAppBarBottom() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Image.asset(
          "assets/images/boy.png",
          width: 150,
          height: 150,
        ));
  }

  AppTextField _getEmailField(
    LoginInitialState loginState,
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return AppTextField(
      initialValue: loginState.email,
      label: localizations.email,
      hintText: localizations.enterYourEmailAddress,
      prefixIcon: const Icon(Icons.person),
      onChanged: ref.read(loginInNotifierProvider.notifier).onEmailChanged,
    );
  }

  AppTextField _getPasswordField(
    LoginInitialState loginProvider,
    AppLocalizations localizations,
    WidgetRef ref,
  ) {
    return AppTextField(
      initialValue: loginProvider.password,
      label: localizations.password,
      hintText: localizations.enterYourPassword,
      prefixIcon: const Icon(Icons.lock),
      suffix: _getPasswordFieldSuffix(loginProvider, ref),
      isObscureText: loginProvider.isPasswordHidden,
      onChanged: ref.read(loginInNotifierProvider.notifier).onPasswordChanged,
    );
  }

  IconButton _getPasswordFieldSuffix(
      LoginInitialState loginProvider, WidgetRef ref) {
    return IconButton(
      icon: loginProvider.isPasswordHidden
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
      onPressed:
          ref.read(loginInNotifierProvider.notifier).onIsPasswordHiddenChanged,
    );
  }

  Widget _getForgotPasswordText(AppLocalizations localizations) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: AppStyles.edgeInsetsH20,
        child: Text(
          localizations.forgotYourPassword + StringUtilities.questionMark,
        ),
      ),
    );
  }

  AppButton _getLoginButton(AppLocalizations localizations, WidgetRef ref) {
    return AppButton(
      title: localizations.login,
      onTap: ref.read(loginInNotifierProvider.notifier).handleLogin,
    );
  }

  AppButton _getSignupButton(
    AppLocalizations localizations,
    BuildContext context,
  ) {
    return AppButton(
      title: localizations.signup,
      onTap: () => AutoRouter.of(context).push(SignupRoute()),
    );
  }

  Widget mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    LoginState loginState,
  ) {
    if (loginState is LoginInitialState) {
      return _buildLoginForm(context, ref, loginState);
    }
    if (loginState is LoginLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    if (loginState is LoginSuccessState) {
      AutoRouter.of(context).replace(const MainRoute());
    }
    if (loginState is LoginFailureState) {
      toastInfo(loginState.errorMessage);
    }
    return const Center(child: CircularProgressIndicator());
  }
}
