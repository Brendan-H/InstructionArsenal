import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/profile/profile_page.dart';

import '../login_page/login_page.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .175,
            child: DrawerHeader(
              decoration: const BoxDecoration(
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      FirebaseAuth.instance.currentUser?.email ?? "Email not found",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? 'Name not found',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Your Instructions'),
            onTap: () async{
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
                    (r) => false,
              );},
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
           ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Log Out'),
             onTap: () async {
               await FirebaseAuth.instance.signOut();
               await Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const LoginPageWidget(),
                 ),
                     (r) => false,
               );
             },
          ),
        ],
      ),
    );
  }
}
