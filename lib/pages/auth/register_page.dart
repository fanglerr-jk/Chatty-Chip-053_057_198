import 'package:wireless/helper/helper_function.dart';
import 'package:wireless/pages/auth/login_page.dart';
import 'package:wireless/pages/home_page.dart';
import 'package:wireless/service/auth_service.dart';
import 'package:wireless/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  String _email = "";
  String _password = "";
  String _fullName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text("Chatty Chip", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("Welcome to Chatty Chip, Register now to start chatting", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                    Image.asset("lib/assets/images/chattychat.png"),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Full Name", prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor)),
                      onChanged: (val) => setState(() => _fullName = val),
                      validator: (val) => val!.isNotEmpty ? null : "Name cannot be empty",
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email", prefixIcon: Icon(Icons.email, color: Theme.of(context).primaryColor)),
                      onChanged: (val) => setState(() => _email = val),
                      validator: (val) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)
                          ? null
                          : "Please enter a valid email",
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.lock, color: Theme.of(context).primaryColor)),
                      onChanged: (val) => setState(() => _password = val),
                      validator: (val) => val!.length < 6 ? "Password must be at least 6 characters" : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        child: const Text("Register", style: TextStyle(color: Colors.white, fontSize: 16)),
                        onPressed: () => _register(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Login now",
                            style: const TextStyle(color: Color.fromARGB(255, 20, 158, 153), decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () => nextScreen(context, const LoginPage()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }



  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await _authService
          .registerUserWithEmailandPassword(_fullName, _email, _password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(_email);
          await HelperFunctions.saveUserNameSF(_fullName);
          nextScreenReplace(context, const HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
