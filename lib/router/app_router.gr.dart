// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:suuq_iibiye/pages/business_information_page.dart' as _i2;
import 'package:suuq_iibiye/pages/category_page.dart' as _i3;
import 'package:suuq_iibiye/pages/home_page.dart' as _i4;
import 'package:suuq_iibiye/pages/login_page.dart' as _i5;
import 'package:suuq_iibiye/pages/main_page.dart' as _i6;
import 'package:suuq_iibiye/pages/signup_page.dart' as _i7;
import 'package:suuq_iibiye/router/authentication_wrapper.dart' as _i1;
import 'package:suuq_iibiye/utils/enums/category_enum.dart' as _i10;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    BusinessInformationRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessInformationRouteArgs>(
          orElse: () => const BusinessInformationRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BusinessInformationPage(key: args.key),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CategoryPage(
          category: args.category,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MainPage(),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SignupPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i8.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i8.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BusinessInformationPage]
class BusinessInformationRoute
    extends _i8.PageRouteInfo<BusinessInformationRouteArgs> {
  BusinessInformationRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BusinessInformationRoute.name,
          args: BusinessInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BusinessInformationRoute';

  static const _i8.PageInfo<BusinessInformationRouteArgs> page =
      _i8.PageInfo<BusinessInformationRouteArgs>(name);
}

class BusinessInformationRouteArgs {
  const BusinessInformationRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'BusinessInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.CategoryPage]
class CategoryRoute extends _i8.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    required _i10.Category category,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            category: category,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i8.PageInfo<CategoryRouteArgs> page =
      _i8.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    required this.category,
    this.key,
  });

  final _i10.Category category;

  final _i9.Key? key;

  @override
  String toString() {
    return 'CategoryRouteArgs{category: $category, key: $key}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MainPage]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignupPage]
class SignupRoute extends _i8.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i8.PageInfo<SignupRouteArgs> page =
      _i8.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}
