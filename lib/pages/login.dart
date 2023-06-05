import 'package:chattychipsapp/assistant/assist_func.dart';
import 'package:chattychipsapp/pages/homepage.dart';
import 'package:chattychipsapp/pages/registration.dart';
import 'package:chattychipsapp/services/authen-service.dart';
import 'package:chattychipsapp/services/database-service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool isLoading = false;
  AuthenService authenService = AuthenService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor))
          : Container(
              color: const Color(0xFFFDFAF0), // Background color
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        Image.asset("lib/images/logo.png"),
                        const Text(
                          "Log in now to connect and chat with others effortlessly!",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0099DC),
                          ),
                        ),
                        const SizedBox(
                            height:
                                50), // Add spacing between the message and Form
                        // Email Filling
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              labelText: "Email",
                              hintText: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFF71C563),
                              )),
                          validator: (val) {
                            if (val?.isEmpty ?? true) {
                              return 'Please input your email';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)) {
                              return 'Please input a valid email';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        // Password Filling
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF71C563), width: 2),
                              ),
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF71C563),
                              )),
                          validator: (val) {
                            if (val?.isEmpty ?? true) {
                              return 'Please input your password';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF71C563)),
                              elevation: MaterialStateProperty.all<double>(0),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                  color: Color(0xFFFDFAF0), fontSize: 16),
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: const Text.rich(
                            TextSpan(
                              text: "Do you have an account?",
                              style: TextStyle(
                                  color: Color(0xFF0099DC), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " Register now",
                                  style: TextStyle(
                                    color: Color(0xFF71C563),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 180,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authenService.LoginWithEmailPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .GettingUserData(email);
          // saving rhe values to the share preferences
          await AssistFunctions.saveUserLogInStatus(true);
          await AssistFunctions.saveUserEmail(email);
          await AssistFunctions.saveUserName(snapshot.docs[0]["username"]);
          await 
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.toString(),
                style: const TextStyle(fontSize: 14),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: "OK",
                onPressed: () {},
                textColor: Colors.white,
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }
}
