import 'dart:convert';
import 'package:based_reviews/pages/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import '../constants/session.dart';
import '../models/user.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController pwConfirmController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Créez votre compte',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 120, child: Text('Username')),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: usernameController,
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
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 120, child: Text('Email')),
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
                                          style: TextStyle(color: Colors.white),
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
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 120, child: Text('Password')),
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
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(
                          width: 120, child: Text('Confirm Password')),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: pwConfirmController,
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
                              } else if (value != passwordController.text) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Passwords do not match',
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
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var pwBytes = utf8.encode(passwordController.text);
                      var pwHash = sha256.convert(pwBytes);

                      await FirebaseFirestore.instance.collection('users').add({
                        'name': usernameController.text,
                        'email': emailController.text,
                        'password': '$pwHash',
                        'image':
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                      }).then((value) {
                        Session.currentUser = User(
                            id: value.id,
                            name: usernameController.text,
                            email: emailController.text,
                            pwHash: '$pwHash',
                            image:
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                            (route) => false);
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Firebase Error',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      });
                    }
                  },
                  child: const Text('Enregistrer')),
            ]),
          ),
        ));
  }
}
