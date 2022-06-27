import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Card(
            borderOnForeground: true,
            child: Container(
              color: Colors.green.shade400,
              height: 200,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: Text("Edit profile"),
            onTap: () {
              Navigator.pushNamed(context, "/editProfile");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Contact developer"),
          ),
          Divider(),
          ListTile(
            title: Text("Logout"),
            leading: Icon(
              Icons.logout,
            ),
            onTap: () async {
              await provider.logout();
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
