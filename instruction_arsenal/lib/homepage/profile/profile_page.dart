import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
                  (r) => false,
            );
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
               Text(
                FirebaseAuth.instance.currentUser!.email ?? 'Email not found',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20,),
               Text(
                FirebaseAuth.instance.currentUser!.displayName ?? 'Name not found',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }
}
