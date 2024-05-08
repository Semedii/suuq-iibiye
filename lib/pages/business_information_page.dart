import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/components/app_textfield.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/utils/field_validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class BusinessInformationPage extends ConsumerWidget {
  BusinessInformationPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    AccountLoadedState state =
        ref.watch(accountNotifierProvider) as AccountLoadedState;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Information"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                validator: (value) =>
                    FieldValidators.required(value, localizations),
              ),
              AppTextField(
                initialValue: state.sellerPhoneNumber,
                label: "Phone number",
                onChanged: ref
                    .read(accountNotifierProvider.notifier)
                    .onPhoneNumberChanged,
                validator: (value) =>
                    FieldValidators.required(value, localizations),
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
              AppButton(
                  title: "Save",
                  isLoading: state.issaveButtonLoading,
                  onTap: () => _onSavePressed(ref))
            ],
          ),
        ),
      ),
    );
  }

  void _onSavePressed(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      ref.read(accountNotifierProvider.notifier).onSaveButtonPressed();
    }
  }
}
