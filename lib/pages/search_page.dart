import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Row(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              enabled: true,
            ),
          ),
          Expanded(
            flex: 0,
            child: Icon(Icons.search),
          )
        ],
      )),
    );
  }
}
