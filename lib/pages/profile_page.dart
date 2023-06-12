import 'package:based_reviews/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../constants/session.dart';
import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 22),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CircleAvatar(
          maxRadius: 50,
          backgroundImage: NetworkImage(
            Session.currentUser.image,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          Session.currentUser.name,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          Session.currentUser.email,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            onPressed: () {
              Session.currentUser =
                  User(id: '', name: '', pwHash: '', email: '', image: '');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
            child: const Text('Log Off'))
      ],
    ));
  }
}
