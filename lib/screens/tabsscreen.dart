import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cut/screens/Profile/pages/profile_page.dart';
import 'package:cut/screens/Saved.dart';
import 'Home.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'page':   Home(), 'label': 'Home'},
    {'page':   Saved(),'label': 'Saves'},
    {'page':   Home(), 'label': 'Search'},
    {'page':   ProfilePage(), 'label': 'Profile'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0xff191A32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
            gap: 4,
            tabBackgroundColor:  Colors.grey.shade800,
            backgroundColor: const Color(0xff191A32),
            color: Colors.white54,
            activeColor: const Color(0xffE72626),
            padding: const EdgeInsets.all(12),
            onTabChange: _onItemTapped,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home',),
              GButton(icon: Icons.favorite_border, text: 'Favorite',),
              GButton(icon: Icons.person_sharp, text: 'Profile',),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex]['page'],
    );
  }
}
