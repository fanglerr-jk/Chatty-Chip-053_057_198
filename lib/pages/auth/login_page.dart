import 'package:wireless/helper/helper_function.dart';
import 'package:wireless/pages/auth/register_page.dart';
import 'package:wireless/pages/home_page.dart';
import 'package:wireless/service/auth_service.dart';
import 'package:wireless/service/database_service.dart';
import 'package:wireless/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthService().signInWithEmailAndPassword(_email, _password);
        // Navigate to home screen
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        // Handle login error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Chatty Chips",
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                        "Welcome back, Login now to see what they are talking!",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    Image.asset("lib/assets/images/chattychat.png"),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email,
                          )),
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      },
                      validator: (val) => val!.isNotEmpty && !val.contains('@')
                          ? "Please enter a valid email"
                          : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock,
                          )),
                      validator: (val) => val!.length < 6
                          ? "Password must be at least 6 characters"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          _password = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: _login,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      child: const Text("Don't have an account? Register here"),
                      onPressed: () {
                        // Navigate to register screen
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
