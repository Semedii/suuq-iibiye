import 'package:auto_route/auto_route.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthenticationWrapper.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CategoryRoute.page),
        AutoRoute(page: BusinessInformationRoute.page),
        AutoRoute(page: OrderHistoryRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: OrderDetailsRoute.page),
        AutoRoute(page: ChangeLanguageRoute.page),
        AutoRoute(page: EditProductRoute.page),
        AutoRoute(page: AddProductRoute.page),
      ];
}
