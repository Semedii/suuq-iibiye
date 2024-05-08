import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:suuq_iibiye/router/app_router.dart';

class MyApp extends StatelessWidget {
  MyApp({required this.env, super.key});

  final String env;

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
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
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      //theme: AppTheme.appThemeData,
      routerConfig: _appRouter.config(),
    );
  }
}
