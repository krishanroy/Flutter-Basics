import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Column(
        children: [
          const Text('Email Verified! we can proceed with the app'),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((_) => Navigator.pop(context));
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
