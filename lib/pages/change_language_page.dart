import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/components/app_button.dart';
import 'package:suuq_iibiye/my_app.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_notifier.dart';
import 'package:suuq_iibiye/notifiers/myProfile/account_state.dart';
import 'package:suuq_iibiye/utils/app_colors.dart';
import 'package:suuq_iibiye/utils/enums/language.dart';

@RoutePage()
class ChangeLanguagePage extends ConsumerWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    AccountLoadedState state =
        ref.watch(accountNotifierProvider) as AccountLoadedState;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.changeLanguage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              localizations.selectLanguage,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildLanguageSection(state, ref),
            const Spacer(),
            AppButton(
              title: localizations.save,
              onTap: () => ref
                  .read(languageNotifierProvider.notifier)
                  .setLocale(languageToLocale(state.language), localizations),
            ),
          ],
        ),
      ),
    );
  }

  _buildLanguageSection(AccountLoadedState state, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildRadio(
          state.language,
          Language.somali,
          "Somali",
          onChanged:
              ref.read(accountNotifierProvider.notifier).onChangeLanguage,
        ),
        _buildRadio(
          state.language,
          Language.english,
          "English",
          onChanged:
              ref.read(accountNotifierProvider.notifier).onChangeLanguage,
        ),
      ],
    );
  }

  Widget _buildRadio(
    Language currentValue,
    Language radioValue,
    String title, {
    void Function(Language?)? onChanged,
  }) {
    return Row(
      children: [
        Radio<Language>(
          fillColor:  MaterialStateProperty.all(AppColors.green),
          value: radioValue,
          groupValue: currentValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }
}
