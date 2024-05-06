import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatar;

  UserModel({this.id, this.name, this.email, this.phoneNumber, this.avatar});

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
        id: data?['uid'],
        name: data?['name'],
        email: data?['email'],
        phoneNumber: data?['phone_number'],
        avatar: data?['phone_number']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      "uid": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "avatar": avatar,
    };
  }
}
