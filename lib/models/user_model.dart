import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  bool isLoggedIn = false;
  Future<bool> userLogin(String email, String password) async {
    var prefs = await SharedPreferences.getInstance();
    if (email.isEmpty! && password.isEmpty!) {
      prefs.setString("email", email);
      prefs.setString("password", password);
      return true;
    } else
      return false;
  }
}
