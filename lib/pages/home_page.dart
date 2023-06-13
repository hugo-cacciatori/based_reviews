import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'movie_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
        child: Column(
      children: [
        SizedBox(height: screenSize.height / 32),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'In theaters :',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('movies')
                .where('year', isEqualTo: '2023')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("waiting");
              }

              return SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data();
                      var movieUID = snapshot.data!.docs[index].id;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 5),
                        child: SizedBox(
                          width: 150,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MoviePage(
                                            movieData: data,
                                            movieUID: movieUID,
                                          ))).then((value) {
                                ScaffoldMessenger.of(context).clearSnackBars();
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  width: 150,
                                  child: Card(
                                      child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(data['image']),
                                            fit: BoxFit.fill)),
                                  )),
                                ),
                                Text(
                                  data['name'],
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            })
      ],
    ));
  }
}
