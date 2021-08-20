import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _codUsuario = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Stack(
                      alignment: Alignment(1, 0),
                      children: [
                        TextField(
                          decoration:
                              InputDecoration(hintText: "Codigo Usuario"),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Stack(alignment: Alignment(1, 0), children: [
                      TextField(
                          decoration: InputDecoration(hintText: "Password"))
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
