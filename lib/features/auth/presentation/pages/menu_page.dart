import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Container(
          color: Theme.of(context).primaryColor,
          height: 200,
        ),
        ExpansionTile(
          title: Text("Mantenimientos"),
          children: [
            ListTile(
              title: Text("Usuarios"),
            )
          ],
        )
      ]),
    );
  }
}
