import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //late is a contract that requires us to initialize it later
  late final TextEditingController _email;
  late final TextEditingController _password;

  //initState is that place where we initialize late fields.
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  //we also have to dispose them
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _email,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter Your Email'),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(hintText: 'Enter Your Password'),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
              print(userCredential.user?.email);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('Weak password');
              } else if (e.code == 'email-already-in-use') {
                print('Email already exists');
              }
            }
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
