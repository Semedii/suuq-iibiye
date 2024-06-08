import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:suuq_iibiye/notifiers/language/language_notifier.dart';
import 'package:suuq_iibiye/router/app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({required this.env, super.key});

  final String env;

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final languageNotifier = ref.watch(languageNotifierProvider);
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          if (env == 'production') return child!;
          return Banner(
            message: env.toUpperCase(),
            location: BannerLocation.topEnd,
            child: child,
          );
        },
        locale: languageNotifier.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _appRouter.config(),
      );
    });
  }
}

final languageNotifierProvider =
    ChangeNotifierProvider((ref) => LanguageNotifier());
