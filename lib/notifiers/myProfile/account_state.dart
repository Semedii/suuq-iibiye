abstract class AccountState {}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState extends AccountState {
  final String sellerName;
  final String sellerEmail;
  final String sellerPhoneNumber;
  final String? sellerAddress;
  final String? sellerAvatar;
  final DateTime sellerJoinedDate;
  final bool issaveButtonLoading;
  final String? newPassword;
  final String? rePassword;

  

  AccountLoadedState({
    required this.sellerName,
    required this.sellerEmail,
    required this.sellerPhoneNumber,
    required this.sellerJoinedDate,
    this.newPassword,
    this.rePassword,
    this.sellerAddress,
    this.sellerAvatar,
    this.issaveButtonLoading=false,
  });

  AccountLoadedState copyWith({
    String? sellerName,
    String? sellerEmail,
    String? sellerPhoneNumber,
    String? sellerAddress,
    String? sellerAvatar,
    DateTime? sellerJoinedDate,
    bool? issaveButtonLoading,
    String? newPassword,
    String? rePassword,
  }) {
    return AccountLoadedState(
      sellerName: sellerName ?? this.sellerName,
      sellerEmail: sellerEmail ?? this.sellerEmail,
      sellerPhoneNumber: sellerPhoneNumber ?? this.sellerPhoneNumber,
      sellerJoinedDate: sellerJoinedDate ?? this.sellerJoinedDate,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      issaveButtonLoading: issaveButtonLoading??this.issaveButtonLoading,
      newPassword: newPassword ?? this.newPassword,
      rePassword: rePassword ?? this.rePassword,
    );
  }
}
