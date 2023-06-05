import 'package:chattychipsapp/assistant/assist_func.dart';
import 'package:chattychipsapp/pages/chatgpt.dart';
import 'package:chattychipsapp/pages/login.dart';
import 'package:chattychipsapp/pages/profile.dart';
import 'package:chattychipsapp/services/authen-service.dart';
import 'package:chattychipsapp/services/database-service.dart';
import 'package:chattychipsapp/widget/grouptile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  AuthenService authenService = AuthenService();
  String username = "";
  String email = "";
  Stream? channels;
  bool isLoading = false;
  String channelname = "";
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await AssistFunctions.getUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });
    await AssistFunctions.getUserName().then((val) {
      setState(() {
        username = val!;
      });
    });
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserChannels()
        .then((snapshot) {
      setState(() {
        channels = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatGPTPage()),
              );
              },
              icon: const Icon(
                Icons.message,
              )),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF71C563),
        title: const Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
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
              username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xFF0099DC),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 15),
            const Divider(height: 2),
            ListTile(
              onTap: () {},
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
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              username: username,
                              email: email,
                            )));
              },
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
                        builder: (context) => const ChatGPTPage()));
              },
              selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.message),
              title: const Text("ChatGPT",
                  style: TextStyle(
                      color: Color(0xFF71C563), fontWeight: FontWeight.bold)),
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
                      color: Color(0xFF71C563), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popupDialog(context);
        },
        elevation: 0,
        backgroundColor: const Color(0xFFF589B3),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  popupDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Create a channel", textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFF589B3),
                        ),
                      )
                    : TextField(
                        onChanged: (value) {
                          setState(() {
                            channelname = value;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFF589B3),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              ],
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (channelname != "") {
                          setState(() {
                            isLoading = true;
                          });
                          DatabaseService(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          ).createChannel(
                            username,
                            FirebaseAuth.instance.currentUser!.uid,
                            channelname,
                          ).whenComplete(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Your channel successfully created!",
                                style: TextStyle(fontSize: 14),
                              ),
                              backgroundColor: const Color(0xFF0099DC),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: "OK",
                                onPressed: () {},
                                textColor: Colors.white,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF71C563),
                      ),
                      child: const Text("create"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF71C563),
                      ),
                      child: const Text("cancel"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}


  Widget groupList() {
  return StreamBuilder(
    stream: channels,
    builder: (context, AsyncSnapshot snapshot) {
      // Make some checks
      if (snapshot.hasData) {
        if (snapshot.data['channels'] != null) {
          if (snapshot.data['channels'].length != 0) {
            return ListView.builder(
              itemCount: snapshot.data['channels'].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data['channels'].length - index - 1;
                return GroupTile(
                  channelid: getId(snapshot.data['channels'][reverseIndex]),
                  channelname: getName(snapshot.data['channels'][reverseIndex]),
                  username: snapshot.data['username'],
                );
              },
            );
          } else {
            return noChannels();
          }
        } else {
          return noChannels();
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }
    },
  );
}


  noChannels() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 250,
          ),
          GestureDetector(
            onTap: () {
              popupDialog(context);
            },
            child: const Icon(
              Icons.add_circle,
              color: Color(0xFF0099DC),
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You haven't joined any channels yet. \n To get started, simply tap on the add icon to create a new channel or use the search button at the top to find channels you're interested in.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
