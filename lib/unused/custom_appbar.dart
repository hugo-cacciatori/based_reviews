import 'package:flutter/material.dart';
import '../pages/search_page.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.screenSize});

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Image.asset(
          'images/logo.png',
          width: screenSize.width / 2.5,
        ),
        elevation: 3,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: const Icon(Icons.search)))
        ]);
  }
}
