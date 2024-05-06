abstract class SignupState {
  const SignupState();
}

class SignupStateInitial extends SignupState {
  final String businessName;
  final String email;
  final String phoneNumber;
  final String password;
  final String rePassword;
  final bool isPasswordHidden;
  final bool isRePasswordHidden;
  final bool isAgreed;
  final bool isButtonLoading;

  SignupStateInitial({
    this.businessName = "",
    this.phoneNumber = "",
    this.email = "",
    this.password = "",
    this.rePassword = "",
    this.isPasswordHidden = true,
    this.isRePasswordHidden = true,
    this.isAgreed = false,
    this.isButtonLoading = false,
  });

  SignupStateInitial copyWith({
    String? businessName,
    String? phoneNumber,
    String? email,
    String? password,
    String? rePassword,
    bool? isPasswordHidden,
    bool? isRePasswordHidden,
    bool? isAgreed,
    bool? isButtonLoading,
  }) {
    return SignupStateInitial(
      businessName: businessName ?? this.businessName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isRePasswordHidden: isRePasswordHidden ?? this.isRePasswordHidden,
      isAgreed: isAgreed ?? this.isAgreed,
      isButtonLoading: isButtonLoading ?? this.isButtonLoading,
    );
  }
}

class SignupStateSuccess extends SignupState {}

class SignupStateLoading extends SignupState {}

class SignupStateFailure extends SignupState {
  final String errorMessage;

  SignupStateFailure({required this.errorMessage});
}
