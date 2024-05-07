

import 'package:suuq_iibiye/models/user_model.dart';

abstract class AccountState{}

class AccountInitialState extends AccountState{}

class AccountLoadingState extends AccountState{}

class AccountLoadedState extends AccountState{
  final UserModel seller;

  AccountLoadedState({required this.seller});
}