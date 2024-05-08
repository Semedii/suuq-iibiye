import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/app_textfield.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';

@RoutePage()
class BusinessInformationPage extends ConsumerWidget {
  const BusinessInformationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AccountLoadedState state =
        ref.watch(accountNotifierProvider) as AccountLoadedState;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppTextField(
              initialValue: state.sellerName,
              label: "Business Name",
              isDisabled: true,
            ),
            AppTextField(
              initialValue: state.sellerAddress,
              label: "Business Address",
              onChanged: ref
                  .read(accountNotifierProvider.notifier)
                  .onBusinessAddressChanged,
            ),
            AppTextField(
              initialValue: state.sellerPhoneNumber,
              label: "Phone number",
              onChanged: ref
                  .read(accountNotifierProvider.notifier)
                  .onPhoneNumberChanged,
            ),
            AppTextField(
              initialValue: state.sellerEmail,
              label: "Email",
              isDisabled: true,
            ),
            AppTextField(
              initialValue: state.sellerJoinedDate.toString(),
              label: "Joined Date",
              isDisabled: true,
            ),
            AppButton(title: "Save", isLoading: state.issaveButtonLoading, onTap: ref.read(accountNotifierProvider.notifier).onSaveButtonPressed)
          ],
        ),
      ),
    );
  }
}
