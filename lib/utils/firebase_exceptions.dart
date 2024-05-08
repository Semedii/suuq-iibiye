import 'package:suuq_iibiye/utils/pop_up_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionHandler {
  static handleFirebaseError(FirebaseException error) {
    switch (error.code) {
      case 'invalid-credential':
        toastInfo("Wrong email or password");
        break;
      case 'invalid-email':
        toastInfo("The email is invalid");
        break;
      case 'email-already-in-use':
        toastInfo("This email is already in use");
        break;
        case 'requires-recent-login':
        toastInfo("This is sensitive information and requires recent login, please logout and login again");
      default:
        toastInfo("An error occurred: ${error.message}");
    }
  }
}
