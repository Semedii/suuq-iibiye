import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/utils/enums/language.dart';

class AuthDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<UserModel?> fetchCurrentUser(String? email) async {
    if (email == null) return null;

    final collectionRef = db
        .collectionGroup("sellers")
        .where('email', isEqualTo: email.toLowerCase())
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (userModel, _) => UserModel().toFirestore(),
        );

    final querySnapshot = await collectionRef.get();

    if (querySnapshot.docs.isEmpty) {
      return null; // No user found with the provided email
    } else {
      return querySnapshot.docs
          .map((doc) => doc.data())
          .firstOrNull; // Returns the first document or null if empty
    }
  }

  Future<void> addNewUser(UserModel user) async {
    try {
      final docRef = db
          .collection("users")
          .doc('sellersDoc')
          .collection('sellers')
          .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, options) => user.toFirestore(),
          )
          .doc(user.email);
      await docRef.set(user);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  Future<void> updateBusinessInfo(
      {required String email,
      required String phoneNumber,
      required String address}) async {
    final updatedData = {"phone_number": phoneNumber, "address": address};
    await db
        .collection('users')
        .doc('sellersDoc')
        .collection("sellers")
        .doc(email)
        .update(updatedData);
  }

  Future<void> updateLanguage({
    required String email,
    required Language language,
  }) async {
    final updatedData = {"language": languageToString(language)};
    await db
        .collection('users')
        .doc('sellersDoc')
        .collection("sellers")
        .doc(email)
        .update(updatedData);
  }
}
