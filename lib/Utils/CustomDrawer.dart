import 'package:chatxfirebase/Screens/SettingScreen.dart';
import 'package:flutter/material.dart';

import '../Services/Auth_Services.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [

          DrawerHeader(
              child: Center(
            child: Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ),
          )),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('H O M E'),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('S E T T I N G'),
              leading: Icon(Icons.settings),
              onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingScreen()));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: (){
                final auth = AuthService();
                 auth.logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
