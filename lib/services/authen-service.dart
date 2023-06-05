import 'package:chattychipsapp/assistant/assist_func.dart';
import 'package:chattychipsapp/services/database-service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Login
  Future LoginWithEmailPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Register
  Future registerUserWithEmailPassword(
      String username, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        // call database service to update the user db
        DatabaseService(uid: user.uid).SavingUserData(username, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Signout
  Future signOut() async {
    try {
      await AssistFunctions.saveUserLogInStatus(false);
      await AssistFunctions.saveUserEmail("");
      await AssistFunctions.saveUserName("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
