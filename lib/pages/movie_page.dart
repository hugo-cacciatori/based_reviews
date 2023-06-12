import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/session.dart';

class MoviePage extends StatefulWidget {
  MoviePage({super.key, required this.movieData, required this.movieUID});

  final Map<String, dynamic> movieData;
  final String movieUID;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    TextEditingController commentController = TextEditingController();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          width: screenSize.width / 2.5,
        ),
        elevation: 3,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movieData['name'],
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 300,
                      width: screenSize.width / 2,
                      child: Image(
                          image: NetworkImage(widget.movieData['image']))),
                  SizedBox(
                    width: screenSize.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movieData['director']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movieUID),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movieData['year']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movieData['description']),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(Session.currentUser.name)));
                      },
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(Session.currentUser.toMap()['image']),
                      ),
                    ),
                    const SizedBox(width: 300, child: TextField()),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('comments')
                      .where('movieID', isEqualTo: widget.movieUID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("error");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("waiting");
                    }

                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              child: SizedBox(width: 150),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
