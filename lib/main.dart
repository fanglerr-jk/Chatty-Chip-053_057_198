import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wireless/pages/auth/login_page.dart';
import 'package:wireless/pages/home_page.dart';
import 'package:wireless/providers/chats_provider.dart';
import 'package:wireless/providers/models_provider.dart';
import 'package:wireless/utils/constants.dart';
import 'package:wireless/utils/helper_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  Future<void> getUserLoggedInStatus() async {
    final value = await HelperFunctions.getUserLoggedInStatus();
    if (value != null) {
      setState(() {
        _isSignedIn = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelsProvider>(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Constants.primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: _isSignedIn ? const HomePage() : const LoginPage(),
      ),
    );
  }
}