import 'package:flutter/material.dart';

import 'login-page.dart';

class SusTransApp extends StatelessWidget {
  const SusTransApp({Key? key}) : super(key: key);

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
        routes: {"/login": (context) => LoginPage()});
  }
}
