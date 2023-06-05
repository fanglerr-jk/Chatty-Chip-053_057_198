import 'package:shared_preferences/shared_preferences.dart';

class AssistFunctions {
  // Keys
  static String userLogInKey = "LOGINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "EMAILKEY";

  // saving the data to SF
  static Future<bool> saveUserLogInStatus(bool isUserLogIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(userLogInKey, isUserLogIn);
  }
  static Future<bool> saveUserName(String userName) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(userNameKey, userName);
  }
  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(userEmailKey, userEmail);
  }

  // get the data from SF
  static Future<bool?> getUserLogInStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(userLogInKey);
  }
  static Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }
  static Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }
}
