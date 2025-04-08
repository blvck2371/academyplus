import 'package:flutter/material.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0; // Indice de l'onglet sélectionné

  // Liste des pages associées à chaque onglet
  final List<Widget> _pages = [
    Center(child: Text('Cours', style: TextStyle(fontSize: 24))),
    Center(child: Text('Épreuves', style: TextStyle(fontSize: 24))),
    Center(child: Text('News', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Affiche la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple, // Couleur de l'élément actif
        unselectedItemColor: Colors.grey, // Couleur des éléments inactifs
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Cours',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Épreuves',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
        ],
      ),
    );
  }
}
