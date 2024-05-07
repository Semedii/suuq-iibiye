
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
part 'account_notifier.g.dart';
@Riverpod()
class AccountNotifier extends _$AccountNotifier{

  @override
  AccountState build(){
    return AccountInitialState();
  }

  initPage()async{
   final String? sellerName = await Global.storageService.getString('sellerName');
   state = AccountLoadedState(sellerName: sellerName);
  }
}