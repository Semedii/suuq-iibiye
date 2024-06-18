import 'package:suuq_iibiye/utils/pop_up_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirebaseExceptionHandler {
  static handleFirebaseError(FirebaseException error, AppLocalizations localizations) {
    switch (error.code) {
      case 'invalid-credential':
        toastInfo(localizations.wrongEmailOrPassword);
        break;
      case 'invalid-email':
        toastInfo(localizations.invalidEmail);
        break;
      case 'email-already-in-use':
        toastInfo(localizations.emailAlreadyInUse);
        break;
        case 'requires-recent-login':
        toastInfo("This is sensitive information and requires recent login, please logout and login again");
      default:
        toastInfo("An error occurred: ${error.message}");
    }
  }
}
