import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:crypto/crypto.dart';
import '../constants/session.dart';
import '../models/user.dart';
import 'dashboard.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(children: [
          SizedBox(height: screenSize.height / 8),
          Image.asset(
            'assets/images/logo.png',
            width: screenSize.width / 1.5,
          ),
          const SizedBox(height: 15),
          const Text("L'appli des cinéphiles"),
          SizedBox(height: screenSize.height / 8),
          SizedBox(
            width: 300,
            height: 160,
            child: Form(
              key: formKey,
              child: Column(children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 65, child: Text('Email')),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 200,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'There are empty fields',
                                          style: TextStyle(color: Colors.white),
                                        )));
                                  return 'Invalid';
                                } else {
                                  if (!EmailValidator.validate(
                                      emailController.text)) {
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(const SnackBar(
                                          duration: Duration(seconds: 1),
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Enter a valid email',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                    return 'Invalid';
                                  }
                                }
                                return null;
                              },
                            ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 65, child: Text('Password')),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 200,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(const SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'There are empty fields',
                                          style: TextStyle(color: Colors.white),
                                        )));
                                  return 'Invalid';
                                }
                                return null;
                              },
                            ))
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    var pwBytes = utf8.encode(passwordController.text);
                    var pwHash = sha256.convert(pwBytes);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .where('email', isEqualTo: emailController.text)
                        .where('password', isEqualTo: '$pwHash')
                        .get()
                        .then((value) {
                      if (value.docs.isEmpty) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'User not found',
                                style: TextStyle(color: Colors.white),
                              )));
                      } else {
                        Session.currentUser = User(
                            id: value.docs[0].id,
                            name: value.docs[0]['name'],
                            pwHash: value.docs[0]['password'],
                            email: value.docs[0]['email'],
                            image: value.docs[0]['image']);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                            (route) => false);
                      }
                    });
                  }
                },
                child: const Text('Se connecter')),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterPage())).then((value) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                  });
                },
                child: const Text('Créer un compte')),
          ),
          SizedBox(height: screenSize.height / 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('©2023 Hugo Cacciatori, Thomas Belaidi, Joseph Laugier ')
            ],
          )
        ]),
      ),
    ));
  }
}
