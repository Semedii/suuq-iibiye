

abstract class AccountState{}

class AccountInitialState extends AccountState{}

class AccountLoadingState extends AccountState{}

class AccountLoadedState extends AccountState{
  final String? sellerName;

  AccountLoadedState({this.sellerName});
}