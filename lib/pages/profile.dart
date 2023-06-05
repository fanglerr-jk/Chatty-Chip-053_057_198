import 'package:chattychipsapp/pages/chatgpt.dart';
import 'package:chattychipsapp/pages/homepage.dart';
import 'package:chattychipsapp/pages/login.dart';
import 'package:chattychipsapp/services/authen-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;

  const ProfilePage({required this.username, required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthenService authenService = AuthenService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF589B3),
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            const SizedBox(height: 15),
            const Icon(
              Icons.account_circle_rounded,
              size: 140,
              color: Color(0xFFF589B3),
            ),
            const SizedBox(height: 8),
            Text(
              widget.username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFF0099DC),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 15),
            const Divider(height: 2),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
             },
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(CupertinoIcons.chat_bubble,
                  color: Color(0xFF0099DC)),
              title: const Text(
                "Chats",
                style: TextStyle(
                    color: Color(0xFFF589B3), fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.person_2),
              title: const Text("Profile",
                  style: TextStyle(
                      color: Color(0xFF71C563), fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatGPTPage()));
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.message),
              title: const Text("ChatGPT",
                  style: TextStyle(
                      color: Color(0xFFF589B3), fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Sign out"),
                      content: const Text("Are you desiring to sign out?"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel_presentation_outlined,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              await authenService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.exit_to_app_sharp,
                              color: Colors.green,
                            ))
                      ],
                    );
                  },
                );
                authenService.signOut().whenComplete(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                });
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app_outlined),
              title: const Text("Sign Out",
                  style: TextStyle(
                      color: Color(0xFFF589B3), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              size: 175,
              color: Color(0xFF71C563),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(color: Color(0xFF0099DC), fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.username,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Color(0xFF0099DC), fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.email,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
