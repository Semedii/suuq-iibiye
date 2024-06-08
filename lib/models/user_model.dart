import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuq_iibiye/utils/enums/language.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? joinedDate;
  Language language;
  String? avatar;
  String? address;

  UserModel({
    this.language = Language.somali,
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
         language: getLanguageFromString(data?['language']),
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
      "language": languageToString(language),
    };
  }
  //for user object in ordermodel
factory UserModel.fromJson(Map<String, dynamic> map) {
     Timestamp createdDate = map['joined_date'];
    return UserModel(
        id: map['uid'],
        name: map['name'],
        email: map['email'],
        address: map['address'],
        joinedDate: createdDate.toDate(),
        phoneNumber: map['phone_number'],
        avatar: map['phone_number']);
  }
}
