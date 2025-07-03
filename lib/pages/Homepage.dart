import 'package:flutter/material.dart';
import 'user.dart';
import 'post_request.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> requestTitles = [
    'Grocery Pickup Request',
    'Package Delivery',
    'Pet Sitting Needed',
    'Water Leakage Repair',
    'Buy Milk and Bread',
    'Laptop Charger Borrow',
    'Help Moving Furniture',
    'Pick Up Laundry',
  ];

  Widget _buildHomeScreen() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requestTitles.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const Icon(Icons.assignment),
            title: Text(requestTitles[index]),
            subtitle: const Text('Tap to view details'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // handle tap
            },
          ),
        );
      },
    );
  }

  Widget _buildProfileScreen() {
    final user = widget.user;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '👤 Hello ' + user.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildInfoTile('Name', user.name),
        _buildInfoTile('Email', user.email),
        _buildInfoTile('Password', user.password),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(title: Text(label), subtitle: Text(value)),
    );
  }

  final Widget _createScreen = const Center(
    child: Text('➕ Create Something', style: TextStyle(fontSize: 22)),
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostRequestPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    if (_selectedIndex == 0) {
      currentScreen = _buildHomeScreen();
    } else if (_selectedIndex == 1) {
      currentScreen = _createScreen;
    } else {
      currentScreen = _buildProfileScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: currentScreen,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabTapped,
        backgroundColor: Colors.deepPurple,
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.deepPurple : Colors.grey,
              onPressed: () => _onItemTapped(0),
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.person),
              color: _selectedIndex == 2 ? Colors.deepPurple : Colors.grey,
              onPressed: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
