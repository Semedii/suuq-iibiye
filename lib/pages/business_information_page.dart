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
        title:  Text(localizations.businessInformation),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                initialValue: state.sellerName,
                label: localizations.businessName,
                isDisabled: true,
              ),
              AppTextField(
                initialValue: state.sellerAddress,
                label: localizations.businessAddress,
                onChanged: ref
                    .read(accountNotifierProvider.notifier)
                    .onBusinessAddressChanged,
                validator: (value) =>
                    FieldValidators.required(value, localizations),
              ),
              AppTextField(
                initialValue: state.sellerPhoneNumber,
                label: localizations.phoneNumber,
                onChanged: ref
                    .read(accountNotifierProvider.notifier)
                    .onPhoneNumberChanged,
                validator: (value) =>
                    FieldValidators.required(value, localizations),
              ),
              AppTextField(
                initialValue: state.sellerEmail,
                label: localizations.email,
                isDisabled: true,
              ),
              AppTextField(
                initialValue: state.sellerJoinedDate.toString(),
                label: localizations.joinedOn,
                isDisabled: true,
              ),
              AppButton(
                  title: localizations.save,
                  isLoading: state.issaveButtonLoading,
                  onTap: () => _onSavePressed(ref, localizations))
            ],
          ),
        ),
      ),
    );
  }

  void _onSavePressed(WidgetRef ref, AppLocalizations localizations) {
    if (_formKey.currentState!.validate()) {
      ref.read(accountNotifierProvider.notifier).onSaveButtonPressed(localizations);
    }
  }
}
