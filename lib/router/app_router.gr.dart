// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:suuq_iibiye/pages/business_information_page.dart' as _i2;
import 'package:suuq_iibiye/pages/categoryPage/category_page.dart' as _i3;
import 'package:suuq_iibiye/pages/categoryPage/edit_product_page.dart' as _i6;
import 'package:suuq_iibiye/pages/change_language_page.dart' as _i4;
import 'package:suuq_iibiye/pages/change_password_page.dart' as _i5;
import 'package:suuq_iibiye/pages/home_page.dart' as _i7;
import 'package:suuq_iibiye/pages/login_page.dart' as _i8;
import 'package:suuq_iibiye/pages/main_page.dart' as _i9;
import 'package:suuq_iibiye/pages/order_detail_page.dart' as _i10;
import 'package:suuq_iibiye/pages/order_history_page.dart' as _i11;
import 'package:suuq_iibiye/pages/signup_page.dart' as _i12;
import 'package:suuq_iibiye/router/authentication_wrapper.dart' as _i1;
import 'package:suuq_iibiye/utils/enums/category_enum.dart' as _i15;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AuthenticationWrapper.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthenticationWrapper(),
      );
    },
    BusinessInformationRoute.name: (routeData) {
      final args = routeData.argsAs<BusinessInformationRouteArgs>(
          orElse: () => const BusinessInformationRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.BusinessInformationPage(key: args.key),
      );
    },
    CategoryRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CategoryPage(
          category: args.category,
          key: args.key,
        ),
      );
    },
    ChangeLanguageRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ChangeLanguagePage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ChangePasswordPage(key: args.key),
      );
    },
    EditProductRoute.name: (routeData) {
      final args = routeData.argsAs<EditProductRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EditProductPage(
          productId: args.productId,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MainPage(),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>(
          orElse: () => const OrderDetailsRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OrderDetailsPage(
          id: args.id,
          key: args.key,
        ),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.OrderHistoryPage(),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>(
          orElse: () => const SignupRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SignupPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthenticationWrapper]
class AuthenticationWrapper extends _i13.PageRouteInfo<void> {
  const AuthenticationWrapper({List<_i13.PageRouteInfo>? children})
      : super(
          AuthenticationWrapper.name,
          initialChildren: children,
        );

  static const String name = 'AuthenticationWrapper';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BusinessInformationPage]
class BusinessInformationRoute
    extends _i13.PageRouteInfo<BusinessInformationRouteArgs> {
  BusinessInformationRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          BusinessInformationRoute.name,
          args: BusinessInformationRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BusinessInformationRoute';

  static const _i13.PageInfo<BusinessInformationRouteArgs> page =
      _i13.PageInfo<BusinessInformationRouteArgs>(name);
}

class BusinessInformationRouteArgs {
  const BusinessInformationRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'BusinessInformationRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.CategoryPage]
class CategoryRoute extends _i13.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    required _i15.Category category,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            category: category,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const _i13.PageInfo<CategoryRouteArgs> page =
      _i13.PageInfo<CategoryRouteArgs>(name);
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    required this.category,
    this.key,
  });

  final _i15.Category category;

  final _i14.Key? key;

  @override
  String toString() {
    return 'CategoryRouteArgs{category: $category, key: $key}';
  }
}

/// generated route for
/// [_i4.ChangeLanguagePage]
class ChangeLanguageRoute extends _i13.PageRouteInfo<void> {
  const ChangeLanguageRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ChangeLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangeLanguageRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i13.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i13.PageInfo<ChangePasswordRouteArgs> page =
      _i13.PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.EditProductPage]
class EditProductRoute extends _i13.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    required String productId,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          EditProductRoute.name,
          args: EditProductRouteArgs(
            productId: productId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProductRoute';

  static const _i13.PageInfo<EditProductRouteArgs> page =
      _i13.PageInfo<EditProductRouteArgs>(name);
}

class EditProductRouteArgs {
  const EditProductRouteArgs({
    required this.productId,
    this.key,
  });

  final String productId;

  final _i14.Key? key;

  @override
  String toString() {
    return 'EditProductRouteArgs{productId: $productId, key: $key}';
  }
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MainPage]
class MainRoute extends _i13.PageRouteInfo<void> {
  const MainRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OrderDetailsPage]
class OrderDetailsRoute extends _i13.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    String? id,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            id: id,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i13.PageInfo<OrderDetailsRouteArgs> page =
      _i13.PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.id,
    this.key,
  });

  final String? id;

  final _i14.Key? key;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{id: $id, key: $key}';
  }
}

/// generated route for
/// [_i11.OrderHistoryPage]
class OrderHistoryRoute extends _i13.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SignupPage]
class SignupRoute extends _i13.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const _i13.PageInfo<SignupRouteArgs> page =
      _i13.PageInfo<SignupRouteArgs>(name);
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}
