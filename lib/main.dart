import 'package:chattychipsapp/pages/homepage.dart';
import 'package:chattychipsapp/assistant/assist_func.dart';
import 'package:chattychipsapp/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:chattychipsapp/providers/models-provider.dart';
import 'package:chattychipsapp/providers/chatprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChattyChipsApp());
}

class ChattyChipsApp extends StatefulWidget {
  const ChattyChipsApp({Key? key}) : super(key: key);

  @override
  State<ChattyChipsApp> createState() => _ChattyChipsAppState();
}

class _ChattyChipsAppState extends State<ChattyChipsApp> {
  bool isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLogInStatus();
  }

  getUserLogInStatus() async {
    await AssistFunctions.getUserLogInStatus().then((value) {
      if (value != null) {
        setState(() {
          isSignedIn = value;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: isSignedIn ? const HomePage() : const LoginPage(),
        ));
  }
}
