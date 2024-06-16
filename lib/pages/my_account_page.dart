import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:suuq_iibiye/notifiers/login/login_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/utils/string_utilities.dart';

class MyAccountPage extends ConsumerWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountNotifierProvider);
    return _mapStateToWidget(context, ref, accountState);
  }

  Widget _mapStateToWidget(
    BuildContext context,
    WidgetRef ref,
    AccountState state,
  ) {
    if (state is AccountInitialState) {
      ref.read(accountNotifierProvider.notifier).initPage();
    } else if (state is AccountLoadedState) {
      return _buildAccountPage(context, state, ref);
    }
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Scaffold _buildAccountPage(
      BuildContext context, AccountLoadedState state, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: AppColors.lightestGrey,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildHeader(
                    context,
                    state.sellerName,
                    state.sellerJoinedDate,
                  ),
                  _buildMenuList(context, ref),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader(
    BuildContext context,
    String name,
    DateTime joinedDate,
  ) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .3,
      decoration: _buildHeaderDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAvatar(),
          _buildSellerNameAndJoinedDate(context, name, joinedDate)
        ],
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
      color: AppColors.green.withOpacity(0.7),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
    );
  }

  Widget _buildSellerNameAndJoinedDate(
      BuildContext context, String name, DateTime joinedDate) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
         const SizedBox(height: 4),
        Center(
          child: Text(
            localizations.joinedOn +
                StringUtilities.colon +
                DateFormat('dd/mm/yyyy').format(joinedDate),
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Positioned _buildMenuList(
    BuildContext context,
    WidgetRef ref,
  ) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Positioned(
        top: MediaQuery.of(context).size.height * .3,
        bottom: 20,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _getMenu(
                    Icons.person,
                    localizations.businessInformation,
                    onTap: () => AutoRouter.of(context).push(
                      BusinessInformationRoute(),
                    ),
                  ),
                  _getMenu(
                    Icons.lock,
                    localizations.changePassword,
                    onTap: () => AutoRouter.of(context).push(
                      ChangePasswordRoute(),
                    ),
                  ),
                  _getMenu(
                    Icons.language,
                    localizations.changeLanguage,
                    onTap: () => AutoRouter.of(context).push(
                      const ChangeLanguageRoute(),
                    ),
                  ),
                  _getMenu(
                    Icons.history,
                    localizations.orderHistory,
                    onTap: () => AutoRouter.of(context).push(
                      const OrderHistoryRoute(),
                    ),
                  ),
                  _getMenu(Icons.person, "About Suuq"),
                  _getMenu(
                    Icons.logout_outlined,
                    localizations.logout,
                    onTap:
                        ref.read(loginInNotifierProvider.notifier).handleLogout,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Card _getMenu(IconData leadingIcon, String title, {void Function()? onTap}) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: onTap,
        leading: Icon(leadingIcon, color: AppColors.green,),
        title: Text(title),
      ),
    );
  }
}
