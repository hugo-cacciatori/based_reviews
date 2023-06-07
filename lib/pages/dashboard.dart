import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/debug.dart';
import '../models/user.dart';
import 'movie_page.dart';
import 'search_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.currentUser});
  final User currentUser;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Map<String, dynamic>> data = [
    {
      'name': 'The Truman Show',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMDIzODcyY2EtMmY2MC00ZWVlLTgwMzAtMjQwOWUyNmJjNTYyXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_.jpg',
      'year': '1998'
    },
    {
      'name': 'Star Wars',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_.jpg',
      'year': '1977'
    },
    {
      'name': 'Harry Potter and the Philosopher\'s stone',
      'image':
          'https://m.media-amazon.com/images/I/815v2OuIHXL._AC_UF1000,1000_QL80_.jpg',
      'year': '2001'
    },
    {
      'name': 'Harry Potter and the Chamber of Secrets',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_.jpg',
      'year': '2002'
    },
    {
      'name': 'Harry Potter and the Prisoner of Azkaban',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_FMjpg_UX1000_.jpg',
      'year': '2004'
    },
    {
      'name': 'Harry Potter and the Goblet of Fire',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_FMjpg_UX1000_.jpg',
      'year': '2005'
    },
    {
      'name': 'Harry Potter and the Order of the Phoenix',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOTA3MmRmZDgtOWU1Ny00ZDc5LWFkN2YtNzNlY2UxZmY0N2IyXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_.jpg',
      'year': '2007'
    },
    {
      'name': 'Harry Potter and the Half Blood Prince',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzU3NDg4NTAyNV5BMl5BanBnXkFtZTcwOTg2ODg1Mg@@._V1_.jpg',
      'year': '2009'
    },
    {
      'name': 'Harry Potter and the Deathly Hallows part 1',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_.jpg',
      'year': '2010'
    },
    {
      'name': 'Harry Potter and the Deathly Hallows part 2',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_.jpg',
      'year': '2011'
    },
    {
      'name': 'Star Wars : The Empire Strikes Back',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
      'year': '1980'
    },
    {
      'name': 'Star Wars : The Return of the Jedi',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/b/b2/ReturnOfTheJediPoster1983.jpg',
      'year': '1983'
    },
    {
      'name': 'The Shining',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTg0MzkzODUwNV5BMl5BanBnXkFtZTgwODM1MjEwNDI@._V1_.jpg',
      'year': '1980'
    },
    {
      'name': 'The Godfather',
      'image':
          'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
      'year': '1972'
    },
    {
      'name': 'Goldeneye',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOWI0MTJlMjEtYTI0ZS00NWZiLWE1ZmItYzBlZTE5YTk3NTJiXkEyXkFqcGdeQXVyMTEwNDU1MzEy._V1_.jpg',
      'year': '1995'
    },
    {
      'name': 'Blade Runner',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'year': '1982'
    },
    {
      'name': 'The Matrix',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'year': '1999'
    },
    {
      'name': 'John Wick',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTU2NjA1ODgzMF5BMl5BanBnXkFtZTgwMTM2MTI4MjE@._V1_.jpg',
      'year': '2014'
    },
    {
      'name': 'The Avengers : Endgame',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg',
      'year': '2019'
    },
    {
      'name': 'The Avengers : Infinity War',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMjMxNjY2MDU1OV5BMl5BanBnXkFtZTgwNzY1MTUwNTM@._V1_.jpg',
      'year': '2018'
    },
    {
      'name': 'The Super Mario Bros Movie',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNjM1NjgzYWQtYzQ3YS00MTU1LTk1MjgtMWI2ZDhhOTJmNjU0XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg',
      'year': '2023'
    },
    {
      'name': 'Guardians of the Galaxy Vol 3',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_UY1200_CR90,0,630,1200_AL_.jpg',
      'year': '2023'
    },
    {
      'name': 'Spider-Man : Across the Spider-Verse',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQ1ODUzYjktMzRiMS00ODNiLWI4NzQtOTRiN2VlNTNmODFjXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg',
      'year': '2023'
    },
    {
      'name': 'Transformers: Rise of the Beasts',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZTNiNDA4NmMtNTExNi00YmViLWJkMDAtMDAxNmRjY2I2NDVjXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
      'year': '2023'
    },
  ];

  var currentMovies = [];

  addData() async {
    await FirebaseFirestore.instance
        .collection('movies')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    for (var element in data) {
      FirebaseFirestore.instance.collection('movies').add(element);
    }
    print('all data added');
  }

  getCurrentMovies() async {
    await FirebaseFirestore.instance
        .collection('movies')
        .where('year', isEqualTo: '2023')
        .get()
        .then(
      (value) {
        currentMovies = value.docs;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (debug) {
      addData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            width: screenSize.width / 2.5,
          ),
          elevation: 3,
          shadowColor: Colors.black,
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage()));
                    },
                    icon: const Icon(Icons.search)))
          ]),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
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
          // SizedBox(
          //   height: 10,
          // ),
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
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                        return SizedBox(
                          width: 140,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MoviePage(movieData: data)));
                            },
                            child: Card(
                                child: DecoratedBox(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(data['image']),
                                      fit: BoxFit.fill)),
                            )),
                          ),
                        );
                      }),
                );
              })
        ],
      )),
    );
  }
}
