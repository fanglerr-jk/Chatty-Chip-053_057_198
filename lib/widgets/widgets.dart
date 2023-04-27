import 'package:flutter/material.dart';

class TextInputDecoration {
  static InputDecoration get decoration => InputDecoration(
        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
        ),
      );
}

void nextScreen(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(BuildContext context, Color color, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
