import 'package:flutter/material.dart';
import 'package:wireless/pages/auth/login_page.dart';
import 'package:wireless/pages/home_page.dart';
import 'package:wireless/service/auth_service.dart';
import 'package:wireless/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;

  const ProfilePage({
    required this.userName,
    required this.email,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.userName),
              accountEmail: Text(widget.email),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.account_circle),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Groups'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              selected: true,
              selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Full Name:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Text(widget.userName, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Email:', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Text(widget.email, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
