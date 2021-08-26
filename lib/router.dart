import 'package:flutter/material.dart';
import 'package:sup_transp_app/features/auth/presentation/pages/login_page.dart';
import 'package:sup_transp_app/features/product/presentation/pages/product/product_list_page.dart';
import 'features/auth/presentation/pages/home_page.dart';

class RouteGenerator {
  static const String loginPage = '/';
  static const String homePage = '/home';
  static const String productPage = '/product';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case productPage:
        return MaterialPageRoute(
          builder: (_) => const ProductListPage(),
        );
      default:
        throw RouteException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
