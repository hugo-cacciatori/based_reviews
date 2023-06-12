import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'movie_page.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";

  TextEditingController searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  autofocus: true,
                  controller: searchFieldController,
                  onChanged: (val) {
                    setState(() {
                      query = val;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Search'),
                ),
              ),
              const Expanded(
                flex: 0,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(Icons.search)),
              )
            ],
          ),
          elevation: 3,
          shadowColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('movies').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      var movieUID = snapshots.data!.docs[index].id;
                      if (query.isEmpty) {
                        return Container();
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase())) {
                        return ListTile(
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['year'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoviePage(
                                        movieData: data,
                                        movieUID: movieUID))).then((value) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                            });
                          },
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
