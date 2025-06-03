import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steet/presentation/dashboard/pages/addAdminPage.dart';
import 'package:steet/presentation/dashboard/pages/adminProfile.dart';
import 'package:steet/presentation/dashboard/pages/dashHome.dart';
import 'package:steet/presentation/profile/pages/profile_page.dart';

class AdminScafold extends StatefulWidget {
  const AdminScafold({super.key});

  @override
  State<AdminScafold> createState() => _AdminScafoldState();
}

class _AdminScafoldState extends State<AdminScafold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashHome(),
    // ModifyRessources(),
    AdminPage(),
    ProfilePage()
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
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAdminPage()),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus_app),
            label: 'Create',
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
