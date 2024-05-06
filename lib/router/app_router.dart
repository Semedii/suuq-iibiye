import 'package:auto_route/auto_route.dart';
import 'package:suuq_iibiye/router/app_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends $AppRouter {

 @override
 List<AutoRoute> get routes => [
  AutoRoute(page: AuthenticationWrapper.page, initial: true),
   AutoRoute(page: LoginRoute.page),
   AutoRoute(page: SignupRoute.page),
   AutoRoute(page: HomeRoute.page)

 ];
}