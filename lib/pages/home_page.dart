import 'package:flutter/material.dart';

import '../models/user.dart';
import 'dashboard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(children: [
        SizedBox(height: screenSize.height / 4),
        Image.asset(
          'assets/images/logo.png',
          width: screenSize.width / 1.5,
        ),
        const SizedBox(height: 15),
        const Text("L'appli des cinéphiles"),
        SizedBox(height: screenSize.height / 4),
        ElevatedButton(
            onPressed: () {
              User currentUser =
                  User(id: 1, name: 'Hugo', pwHash: 'XYZ', login: 'hugo');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Dashboard(currentUser: currentUser)),
                  (route) => false);
            },
            child: const Text('Se connecter')),
        SizedBox(height: screenSize.height / 3.6),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('©2023 Hugo Cacciatori, Thomas Belaidi, Joseph Laugier ')
          ],
        )
      ]),
    ));
  }
}
