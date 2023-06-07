import 'package:based_reviews/pages/search_page.dart';
import 'package:based_reviews/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  MoviePage({super.key, required this.movieData});

  Map<String, dynamic> movieData;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          width: screenSize.width / 2.5,
        ),
        elevation: 3,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [Text(widget.movieData['name'])],
      ),
    );
  }
}
