import 'package:flutter/material.dart';

import 'features/auth/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/mantenimientos/presentation/pages/product/product_list_page.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // theme of our application.
          primaryColor: Color(0xff3B7FFF),
          errorColor: Colors.red,
          inputDecorationTheme:
              InputDecorationTheme(fillColor: Colors.transparent),
          primaryColorDark: Color(0xAf3B7FFF),
          accentColor: Color(0Xff0971E8),
          backgroundColor: Colors.transparent,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LoginPage(),
          "/home": (context) => HomePage(),
          "/product": (context) => ProductListPage()
        });
  }
}
