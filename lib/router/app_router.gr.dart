// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:suuq_iibiye/models/order.dart' as _i14;
import 'package:suuq_iibiye/pages/business_information_page.dart' as _i2;
import 'package:suuq_iibiye/pages/categoryPage/category_page.dart' as _i3;
import 'package:suuq_iibiye/pages/change_password_page.dart' as _i4;
import 'package:suuq_iibiye/pages/home_page.dart' as _i5;
import 'package:suuq_iibiye/pages/login_page.dart' as _i6;
import 'package:suuq_iibiye/pages/main_page.dart' as _i7;
import 'package:suuq_iibiye/pages/order_detail_page.dart' as _i8;
import 'package:suuq_iibiye/pages/order_history_page.dart' as _i9;
import 'package:suuq_iibiye/pages/signup_page.dart' as _i10;
import 'package:suuq_iibiye/router/authentication_wrapper.dart' as _i1;
import 'package:suuq_iibiye/utils/enums/category_enum.dart' as _i13;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    BusinessInformationRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessInformationRouteArgs>(
          orElse: () => const BusinessInformationRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BusinessInformationPage(key: args.key),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CategoryPage(
          category: args.category,
          key: args.key,
        ),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ChangePasswordPage(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MainPage(),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.OrderDetailsPage(
          order: args.order,
          key: args.key,
        ),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.OrderHistoryPage(),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.SignupPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i11.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i11.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BusinessInformationPage]
class BusinessInformationRoute
    extends _i11.PageRouteInfo<BusinessInformationRouteArgs> {
  BusinessInformationRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          BusinessInformationRoute.name,
          args: BusinessInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BusinessInformationRoute';

  static const _i11.PageInfo<BusinessInformationRouteArgs> page =
      _i11.PageInfo<BusinessInformationRouteArgs>(name);
}

class BusinessInformationRouteArgs {
  const BusinessInformationRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'BusinessInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.CategoryPage]
class CategoryRoute extends _i11.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    required _i13.Category category,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            category: category,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i11.PageInfo<CategoryRouteArgs> page =
      _i11.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    required this.category,
    this.key,
  });

  final _i13.Category category;

  final _i12.Key? key;

  @override
  String toString() {
    return 'CategoryRouteArgs{category: $category, key: $key}';
  }
}

/// generated route for
/// [_i4.ChangePasswordPage]
class ChangePasswordRoute extends _i11.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i11.PageInfo<ChangePasswordRouteArgs> page =
      _i11.PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MainPage]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OrderDetailsPage]
class OrderDetailsRoute extends _i11.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    required _i14.OrderModel order,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            order: order,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i11.PageInfo<OrderDetailsRouteArgs> page =
      _i11.PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    required this.order,
    this.key,
  });

  final _i14.OrderModel order;

  final _i12.Key? key;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{order: $order, key: $key}';
  }
}

/// generated route for
/// [_i9.OrderHistoryPage]
class OrderHistoryRoute extends _i11.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i11.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SignupPage]
class SignupRoute extends _i11.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i11.PageInfo<SignupRouteArgs> page =
      _i11.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}
