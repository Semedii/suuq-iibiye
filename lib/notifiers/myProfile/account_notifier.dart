import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/services/auth_data_service.dart';
import 'package:suuq_iibiye/services/auth_service.dart';
import 'package:suuq_iibiye/utils/enums/language.dart';
import 'package:suuq_iibiye/utils/pop_up_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'account_notifier.g.dart';

@Riverpod()
class AccountNotifier extends _$AccountNotifier {
  final AuthDataService _authDataService = AuthDataService();
  final AuthService _authService = AuthService();
  @override
  AccountState build() {
    return AccountInitialState();
  }

  initPage() async {
    final String? sellerEmail =
        await Global.storageService.getString('sellerEmail');
    final UserModel? seller =
        await _authDataService.fetchCurrentUser(sellerEmail);
    state = AccountLoadedState(
        sellerName: seller!.name!,
        sellerEmail: seller.email!,
        language: seller.language,
        sellerPhoneNumber: seller.phoneNumber!,
        sellerJoinedDate: seller.joinedDate!,
        sellerAddress: seller.address,
        sellerAvatar: seller.avatar);
  }

  onBusinessAddressChanged(String address) {
    state = (state as AccountLoadedState).copyWith(sellerAddress: address);
  }

  onPhoneNumberChanged(String phoneMumber) {
    state =
        (state as AccountLoadedState).copyWith(sellerPhoneNumber: phoneMumber);
  }

  onNewPasswordChanged(String newPassword) {
    state = (state as AccountLoadedState).copyWith(newPassword: newPassword);
  }

  onRePasswordChanged(String rePassword) {
    state = (state as AccountLoadedState).copyWith(rePassword: rePassword);
  }

    onChangeLanguage(Language? language) {
    state = (state as AccountLoadedState).copyWith(language: language);
  }

  onSavePassword(AppLocalizations localizations) async {
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authService.changePassword(currentState.newPassword!, localizations);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo(localizations.successfullyUpdated);
  }

  onSaveButtonPressed(AppLocalizations localizations) async {
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authDataService.updateBusinessInfo(
        email: currentState.sellerEmail,
        phoneNumber: currentState.sellerPhoneNumber,
        address: currentState.sellerAddress!);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo(localizations.successfullyUpdated);
  }

  onSaveLanguagePressed(String succesfullMessage) async {
    String? sellerEmail = FirebaseAuth.instance.currentUser?.email!;
    var currentState = state as AccountLoadedState;
    state = currentState.copyWith(issaveButtonLoading: true);
    await _authDataService.updateLanguage(
        email: sellerEmail!, language: currentState.language);
    state = currentState.copyWith(issaveButtonLoading: false);
    toastInfo(succesfullMessage);
  }
}
