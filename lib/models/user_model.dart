import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? joinedDate;
  String? avatar;
  String? address;

  UserModel({
    this.joinedDate,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.address,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Timestamp createdDate = data?['joined_date'];
    return UserModel(
        joinedDate: createdDate.toDate(),
        id: data?['uid'],
        name: data?['name'],
        email: data?['email'],
        phoneNumber: data?['phone_number'],
        avatar: data?['avatar'],
        address: data?['address']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'joined_date': joinedDate,
      "uid": id,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "avatar": avatar,
      "address": address,
    };
  }
}
