import 'package:firebase_auth/firebase_auth.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/services/auth_data_service.dart';
import 'package:suuq_iibiye/utils/firebase_exceptions.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthDataService _authDataService = AuthDataService();

  Future<UserModel?> signup(String businessName, String phoneNumber,
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = credential.user;
      if (firebaseUser != null) {
        UserModel newUser = UserModel(
          id: firebaseUser.uid,
          name: businessName,
          email: firebaseUser.email,
          phoneNumber: phoneNumber,
          avatar: firebaseUser.photoURL,
        );
        await _authDataService.addNewUser(newUser);
      }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final UserModel? userModel =
            await _authDataService.fetchCurrentUser(email);
        if (userModel != null) {
          Global.storageService.setString("sellerName", userModel.name!);
          Global.storageService.setString("sellerEmail", email);
          return userModel;
        } else {
          await logout();
        }
      }
    } on FirebaseException catch (e) {
      FirebaseExceptionHandler.handleFirebaseError(e);
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
     Global.storageService.clear();
  }
}
