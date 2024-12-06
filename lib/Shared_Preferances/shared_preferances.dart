import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferances {
  Future<void> saveCartItemListLocally(List<int> userCartItems) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("CartItems", jsonEncode(userCartItems));
  }

  Future<List> getCartItemListFromLocalStorage() async {
    var ListItem = [];
    var prefs = await SharedPreferences.getInstance();
    var data = (prefs.getString("CartItems"));
    if (data != null) {
      ListItem = jsonDecode(data);
      print(ListItem);
    }
    return ListItem;
  }
}
