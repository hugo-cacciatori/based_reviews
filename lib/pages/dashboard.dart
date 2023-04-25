import 'package:flutter/material.dart';
import '../constants/default_values.dart';
import '../models/user.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
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

  @override
  void initState() {
    super.initState();
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
          // automaticallyImplyLeading: false,
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchPage()));
                    },
                    icon: const Icon(Icons.search)))
          ]),
      drawer: CustomDrawer(fun: () {}),
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
          SizedBox(height: screenSize.height / 4),
        ],
      )),
    );
  }
}
