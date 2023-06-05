import 'package:chattychipsapp/services/authen-service.dart';
import 'package:flutter/material.dart';
import 'package:chattychipsapp/assistant/assist_func.dart';

import 'homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String password = "";
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
                          "Sign up to create an account and join our community!",
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
                          keyboardType: TextInputType.text,
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
                              labelText: "Username",
                              hintText: "Username",
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF71C563),
                              )),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                              labelText: "Password",
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
                              "Register",
                              style: TextStyle(
                                  color: Color(0xFFFDFAF0), fontSize: 16),
                            ),
                            onPressed: () {
                              register();
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
                              text: "Already have an account?",
                              style: TextStyle(
                                  color: Color(0xFF0099DC), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: " Login now",
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

  register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authenService
          .registerUserWithEmailPassword(username, email, password)
          .then((value) async {
        if (value == true) {
          //saving the shared preference state
          await AssistFunctions.saveUserLogInStatus(true);
          await AssistFunctions.saveUserEmail(email);
          await AssistFunctions.saveUserName(username);
          Navigator.push(context, MaterialPageRoute( builder: (context) => const HomePage()));
          
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
