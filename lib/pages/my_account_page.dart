import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/notifiers/login/login_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';

class MyAccountPage extends ConsumerWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountNotifierProvider);
    return _mapStateToWidget(context, ref, accountState);
  }

  Widget _mapStateToWidget(BuildContext context, WidgetRef ref, AccountState state){
    if(state is AccountInitialState){
      ref.read(accountNotifierProvider.notifier).initPage();
    }else if (state is AccountLoadedState){
      return _buildAccountPage(context, state,ref);
    }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

  }

  Scaffold _buildAccountPage(BuildContext context, AccountLoadedState state,WidgetRef ref) {
    return Scaffold(
    body: Container(
      color: AppColors.lightestGrey,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildHeader(context, state.sellerName),
                _buildMenuList(context, ref),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  }

  Container _buildHeader(BuildContext context, String? name) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .4,
      decoration: _buildHeaderDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildAvatar(), _buildusername(name)],
      ),
    );
  }

  CircleAvatar _buildAvatar() {
    return const CircleAvatar(
      backgroundImage: AssetImage("assets/images/boy.png"),
      radius: 50,
    );
  }

  BoxDecoration _buildHeaderDecoration() {
    return BoxDecoration(
      color: AppColors.lighterGrey,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),
    );
  }

  Text _buildusername(String? name) {
    return Text(
      name ?? "",
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    );
  }

  Positioned _buildMenuList(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Positioned(
        top: MediaQuery.of(context).size.height * .42,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _getMenu(Icons.person, "Company Information"),
                _getMenu(Icons.lock, "Change Password"),
                _getMenu(Icons.history, "Order History"),
                _getMenu(Icons.person, "About Suuq"),
                _getMenu(
                  Icons.logout_outlined,
                  "Logout",
                  onTap:
                      ref.read(loginInNotifierProvider.notifier).handleLogout,
                ),
              ],
            ),
          ),
        ));
  }

  Card _getMenu(IconData leadingIcon, String title, {void Function()? onTap}) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon),
        title: Text(title),
      ),
    );
  }
}
