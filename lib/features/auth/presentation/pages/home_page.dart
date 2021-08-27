import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sup_transp_app/core/network/headers.dart';
import 'package:sup_transp_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:sup_transp_app/injection_container.dart';

import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> numeros = {"1": "one", "2": "dos"};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numeros["3"] = "tres";
    sl<Headers>().headers.addAll({'h': 'h'});
  }

  _logout() {
    BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuPage(),
      appBar: AppBar(),
      body: Column(
        children: [
          Text(jsonEncode(sl<Headers>().headers)),
          /* Text(context.watch<AuthBloc>().codUsuario ?? '' )*/
          Text(
              BlocProvider.of<AuthBloc>(context, listen: true).codUsuario ?? '')
        ],

        //child: Text(jsonEncode(numeros)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.access_alarm),
        onPressed: _logout,
      ),
    );
  }
}
