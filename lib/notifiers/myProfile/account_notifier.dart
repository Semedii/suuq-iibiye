
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:suuq_iibiye/global.dart';
import 'package:suuq_iibiye/models/user_model.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/services/auth_data_service.dart';

part 'account_notifier.g.dart';
@Riverpod()
class AccountNotifier extends _$AccountNotifier{

  @override
  AccountState build(){
    return AccountInitialState();
  }

  initPage()async{
   final String? sellerEmail = await Global.storageService.getString('sellerEmail');
   final UserModel? seller = await AuthDataService().fetchCurrentUser(sellerEmail);
   state = AccountLoadedState(seller: seller!);
  }
}