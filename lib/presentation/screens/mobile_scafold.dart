import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steet/presentation/profile/pages/profile_page.dart';
import 'package:steet/presentation/home/pages/home_page.dart';
import 'package:steet/presentation/rooms/pages/rooms_page.dart';
import 'package:steet/presentation/notifications/pages/notifications_page.dart';

class MobileScafold extends StatefulWidget {
  const MobileScafold({super.key});

  @override
  State<MobileScafold> createState() => _MobileScafoldState();
}

class _MobileScafoldState extends State<MobileScafold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    RoomsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Image.asset("lib/assets/images/logo.png"),
        ),
        title: const Text('Steet'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.bell),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        // selectedItemColor: Theme.of(context).colorScheme.primary,
        // unselectedItemColor: const Color(0xff757575),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.rectangle_stack_person_crop),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
