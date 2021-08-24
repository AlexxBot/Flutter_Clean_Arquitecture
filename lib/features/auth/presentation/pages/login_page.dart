import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sup_transp_app/core/widgets/widgets.dart';
import 'package:sup_transp_app/features/auth/presentation/bloc/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _codUsuarioController =
      TextEditingController(text: "alex.hotmail.com");
  TextEditingController _passwordController =
      TextEditingController(text: "alex");

  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void _login() {
    authBloc.add(LoginEvent(
        codUsuario: _codUsuarioController.text,
        password: _passwordController.text));
  }

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
            BlocListener<AuthBloc, AuthState>(
              bloc: authBloc,
              listener: (context, state) {
                if (state is LoadingState) {
                  LoadingWidget.show(context);
                }
                if (state is LoggedInState) {
                  print("this is the token : " + state.token);
                  /* _codUsuarioController.clear();
                  _passwordController.clear(); */
                  LoadingWidget.hide(context);
                  Navigator.pushNamed(context, '/home');
                }
                /* if(state is ErrorState){

                  } */
              },
              child: Form(
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
                            controller: _codUsuarioController,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Stack(alignment: Alignment(1, 0), children: [
                        TextField(
                            decoration: InputDecoration(hintText: "Password"),
                            controller: _passwordController)
                      ]),
                    ),
                    ButtonWidget(title: "Login", onPressed: _login)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
