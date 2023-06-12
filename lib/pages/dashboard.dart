import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants/debug.dart';
import '../models/user.dart';
import 'home_page.dart';
import 'movie_page.dart';
import 'profile_page.dart';
import 'search_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});

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

  List<Map<String, dynamic>> moviesData = [
    {
      'name': 'The Truman Show',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMDIzODcyY2EtMmY2MC00ZWVlLTgwMzAtMjQwOWUyNmJjNTYyXkEyXkFqcGdeQXVyNDk3NzU2MTQ@._V1_.jpg',
      'year': '1998',
      'director': 'Peter Weir',
      'description': 'Film super cool qui raconte l\'histoire de Truman.',
    },
    {
      'name': 'Star Wars',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOTA5NjhiOTAtZWM0ZC00MWNhLThiMzEtZDFkOTk2OTU1ZDJkXkEyXkFqcGdeQXVyMTA4NDI1NTQx._V1_.jpg',
      'year': '1977',
      'director': 'George Lucas',
      'description': 'Premier épisode de la saga Star Wars.'
    },
    {
      'name': 'Harry Potter and the Philosopher\'s stone',
      'image':
          'https://m.media-amazon.com/images/I/815v2OuIHXL._AC_UF1000,1000_QL80_.jpg',
      'year': '2001',
      'director': 'Chris Columbus',
      'description':
          'Harry Potter, un jeune orphelin, est élevé par son oncle et sa tante qui le détestent. Alors qu\'il était haut comme trois pommes, ces derniers lui ont raconté que ses parents étaient morts dans un accident de voiture.'
    },
    {
      'name': 'Harry Potter and the Chamber of Secrets',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_.jpg',
      'year': '2002',
      'director': 'Chris Columbus',
      'description':
          'Alors que l\'oncle Vernon, la tante Pétunia et son cousin Dudley reçoivent d\'importants invités à dîner, Harry Potter est contraint de passer la soirée dans sa chambre. Dobby, un elfe, fait alors son apparition.'
    },
    {
      'name': 'Harry Potter and the Prisoner of Azkaban',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_FMjpg_UX1000_.jpg',
      'year': '2004',
      'director': 'Alfonso Cuarón',
      'description':
          'Sirius Black, un dangereux sorcier criminel, s\'échappe de la sombre prison d\'Azkaban avec un seul et unique but : se venger d\'Harry Potter, entré avec ses amis Ron et Hermione en troisième année à l\'école de sorcellerie de Poudlard, où ils auront aussi à faire avec les terrifiants Détraqueurs.'
    },
    {
      'name': 'Harry Potter and the Goblet of Fire',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTI1NDMyMjExOF5BMl5BanBnXkFtZTcwOTc4MjQzMQ@@._V1_FMjpg_UX1000_.jpg',
      'year': '2005',
      'director': 'Mike Newell',
      'description':
          'La quatrième année à l\'école de Poudlard est marquée par le Tournoi des trois sorciers. Les participants sont choisis par la fameuse coupe de feu, qui est à l\'origine d\'un scandale. Elle sélectionne Harry Potter tandis qu\'il n\'a pas l\'âge légal requis.'
    },
    {
      'name': 'Harry Potter and the Order of the Phoenix',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOTA3MmRmZDgtOWU1Ny00ZDc5LWFkN2YtNzNlY2UxZmY0N2IyXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_.jpg',
      'year': '2007',
      'director': 'David Yates',
      'description':
          'À sa cinquième année à l\'école de sorcellerie de Poudlard, Harry Potter passe pour un illuminé, le ministre de la magie Cornelius Fudge ayant officiellement réfuté les révélations de l\'adolescent et de son directeur, Dumbleore, disant que le terrifiant Lord Voldermort est de retour'
    },
    {
      'name': 'Harry Potter and the Half Blood Prince',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzU3NDg4NTAyNV5BMl5BanBnXkFtZTcwOTg2ODg1Mg@@._V1_.jpg',
      'year': '2009',
      'director': 'David Yates',
      'description':
          'Cette sixième année scolaire de Harry Potter à l\'école de sorciers commence par une dispute avec son ennemi juré Draco Malfoy, en qui les forces des ténèbres placent désormais leurs espoirs.'
    },
    {
      'name': 'Harry Potter and the Deathly Hallows part 1',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTQ2OTE1Mjk0N15BMl5BanBnXkFtZTcwODE3MDAwNA@@._V1_.jpg',
      'year': '2010',
      'director': 'David Yates',
      'description':
          'Sans les conseils et la protection de leurs professeurs, Harry, Ron et Hermione ont pour mission de détruire les horcruxes, les origines de l\'immortalité de Voldemort. Bien que plus que jamais ils doivent compter l\'un sur l\'autre, les forces du mal menacent de les désunir.'
    },
    {
      'name': 'Harry Potter and the Deathly Hallows part 2',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_.jpg',
      'year': '2011',
      'director': 'David Yates',
      'description':
          'Dans la deuxième partie de cette finale épique, la bataille entre les forces du bien et celles du mal du monde des magiciens dégénère en une guerre tous azimuts. Les enjeux n\'ont jamais été si grands et personne n\'est en sécurité.'
    },
    {
      'name': 'Star Wars : The Empire Strikes Back',
      'image':
          'https://m.media-amazon.com/images/M/MV5BYmU1NDRjNDgtMzhiMi00NjZmLTg5NGItZDNiZjU5NTU4OTE0XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
      'year': '1980',
      'director': 'Irvin Kershner',
      'description':
          'Malgré la destruction de l\'Étoile noire, l\'Empire maintient son emprise sur la galaxie, et poursuit sans relâche sa lutte contre l\'Alliance rebelle. Basés sur la planète glacée de Hoth, les rebelles essuient un assaut des troupes impériales.'
    },
    {
      'name': 'Star Wars : The Return of the Jedi',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/b/b2/ReturnOfTheJediPoster1983.jpg',
      'year': '1983',
      'director': 'Richard Marquand',
      'description':
          'L\'empire galactique est plus puissant que jamais : la construction de la nouvelle arme, l\'étoile de la mort, menace l\'univers tout entier... Han Solo est remis à l\'ignoble contrebandier Jabba le Hutt par le chasseur de primes Boba Fett. après l\'échec d\'une première tentative d\'évasion menée par la princesse Leia, également arrêtée par Jabba, Luke Skywalker et Lando parviennent à libérer leurs amis'
    },
    {
      'name': 'The Shining',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTg0MzkzODUwNV5BMl5BanBnXkFtZTgwODM1MjEwNDI@._V1_.jpg',
      'year': '1980',
      'director': 'Stanley Kubrick',
      'description':
          'Jack Torrance, gardien d\'un hôtel fermé l\'hiver, sa femme et son fils Danny s\'apprêtent à vivre de longs mois de solitude. Danny, qui possède un don de médium, le Shining, est effrayé à l\'idée d\'habiter ce lieu, théâtre marqué par de terribles évènements passés...'
    },
    {
      'name': 'The Godfather',
      'image':
          'https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
      'year': '1972',
      'director': ' Francis Ford Coppola',
      'description':
          'En 1945, à New York, les Corleone sont une des 5 familles de la mafia. Don Vito Corleone, parrain de cette famille, marie sa fille à un bookmaker. Sollozzo, parrain de la famille Tattaglia, propose à Don Vito une association dans le trafic de drogue, mais celui-ci refuse.'
    },
    {
      'name': 'Goldeneye',
      'image':
          'https://m.media-amazon.com/images/M/MV5BOWI0MTJlMjEtYTI0ZS00NWZiLWE1ZmItYzBlZTE5YTk3NTJiXkEyXkFqcGdeQXVyMTEwNDU1MzEy._V1_.jpg',
      'year': '1995',
      'director': 'Martin Campbell',
      'description':
          'James Bond est chargé par le MI6 de retrouver le Goldeneye, un satellite russe volé par des mercenaires, dont la puissance de frappe pourrait rayer de la carte n\'importe quelle capitale.'
    },
    {
      'name': 'Blade Runner',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'year': '1982',
      'director': 'Ridley Scott',
      'description':
          'En l\'an 2019, un ex-policier devenu détective privé, Rick Deckard, est rappelé en service pour faire la chasse à des robots d\'apparence humaine appelés "replicants." Deckard doit en éliminer quatre qui se cachent à Los Angeles.'
    },
    {
      'name': 'The Matrix',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_.jpg',
      'year': '1999',
      'director': 'Lana Wachowski, Lilly Wachowski',
      'description':
          'Programmeur anonyme dans un service administratif le jour, Thomas Anderson devient Neo la nuit venue. Sous ce pseudonyme, il est l\'un des pirates les plus recherchés du cyber-espace'
    },
    {
      'name': 'John Wick',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTU2NjA1ODgzMF5BMl5BanBnXkFtZTgwMTM2MTI4MjE@._V1_.jpg',
      'year': '2014',
      'director': 'Chad Stahelski',
      'description':
          'Ce qui aurait pu être le banal vol d\'une voiture de collection se transforme en une chasse à l\'homme sans merci entre un légendaire ex-tueur à gages et le fils d\'un des plus grands pontes de la mafia.'
    },
    {
      'name': 'The Avengers : Endgame',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg',
      'year': '2019',
      'director': 'Anthony Russo, Joe Russo',
      'description':
          'Le Titan Thanos, ayant réussi à s\'approprier les six Pierres d\'Infinité et à les réunir sur le Gantelet doré, a pu réaliser son objectif de pulvériser la moitié de la population de l\'Univers.'
    },
    {
      'name': 'The Avengers : Infinity War',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMjMxNjY2MDU1OV5BMl5BanBnXkFtZTgwNzY1MTUwNTM@._V1_.jpg',
      'year': '2018',
      'director': ' Anthony Russo, Joe Russo',
      'description':
          'Alors que les Avengers et leurs alliés ont continué de protéger le monde face à des menaces bien trop grandes pour être combattues par un héros seul, un nouveau danger est venu de l\'espace : Thanos'
    },
    {
      'name': 'The Super Mario Bros Movie',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNjM1NjgzYWQtYzQ3YS00MTU1LTk1MjgtMWI2ZDhhOTJmNjU0XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg',
      'year': '2023',
      'director': 'Aaron Horvath, Michael Jelenic',
      'description':
          'Un plombier nommé Mario parcourt un labyrinthe souterrain avec son frère, Luigi, essayant de sauver une princesse capturée. Adaptation cinématographique du célèbre jeu vidéo.'
    },
    {
      'name': 'Guardians of the Galaxy Vol 3',
      'image':
          'https://m.media-amazon.com/images/M/MV5BMDgxOTdjMzYtZGQxMS00ZTAzLWI4Y2UtMTQzN2VlYjYyZWRiXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_UY1200_CR90,0,630,1200_AL_.jpg',
      'year': '2023',
      'director': 'James Gunn',
      'description':
          'Les Gardiens de la Galaxie vont devoir combattre à nouveau Ayesha, la prêtresse des Souverains, faire face au créateur de Rocket qui veut le récupérer à tout prix et défier Adam Warlock prêt à tout pour les tuer.'
    },
    {
      'name': 'Spider-Man : Across the Spider-Verse',
      'image':
          'https://m.media-amazon.com/images/M/MV5BNzQ1ODUzYjktMzRiMS00ODNiLWI4NzQtOTRiN2VlNTNmODFjXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg',
      'year': '2023',
      'director': 'Joaquim Dos Santos, Kemp Powers, Justin K. Thompson',
      'description':
          'Après avoir retrouvé Gwen Stacy, Spider-Man, la sympathique araignée du quartier à temps plein de Brooklyn, est catapulté à travers le multivers, où il rencontre une équipe de Spider-People chargée de protéger son existence même..'
    },
    {
      'name': 'Transformers: Rise of the Beasts',
      'image':
          'https://m.media-amazon.com/images/M/MV5BZTNiNDA4NmMtNTExNi00YmViLWJkMDAtMDAxNmRjY2I2NDVjXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
      'year': '2023',
      'director': 'Steven Caple Jr.',
      'description':
          'Les Decepticons viennent d\'arriver sur Terre en 1994, tout comme Optimus Prime, qui existe depuis un peu plus longtemps. L\'archéologue Elena et le soldat Noah au Pérou découvrent les traces d\'un ancien conflit de transformateurs sur Terre.'
    },
  ];

  addData() async {
    await FirebaseFirestore.instance
        .collection('movies')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    for (var element in moviesData) {
      FirebaseFirestore.instance.collection('movies').add(element);
    }

    await FirebaseFirestore.instance
        .collection('movies')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        FirebaseFirestore.instance
            .collection('comments')
            .add({'movieID': ds.id});
      }
    });

    print('all data added');
  }

  final List<Widget> _pages = [HomePage(), const ProfilePage()];

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
        body: _pages[_selectedIndex]);
  }
}
