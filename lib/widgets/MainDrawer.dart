import 'package:flutter/material.dart';
import 'package:nopshop/screens/Orders_Screen.dart';
import 'package:nopshop/screens/UsersProductScreen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFFFFFFEE), const Color(0xFF999999)]),
            ),
            child: FittedBox(
              child: Center(
                child: Text(
                  "Using As Guest.",
                  softWrap: true,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed("/");
            },
            leading: CircleAvatar(
              child: Icon(Icons.shop),
            ),
            title: Text("Products"),
            subtitle: Text(
              "All Your Essential Product Are Available here.",
              softWrap: true,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
            leading: CircleAvatar(
              child: Icon(Icons.payment),
            ),
            title: Text("Orders"),
            subtitle: Text(
              "All Your Orders Are here",
              softWrap: true,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
            leading: CircleAvatar(
              child: Icon(Icons.work),
            ),
            title: Text("User Products"),
            subtitle: Text(
              "Manage All Your Products here.",
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
