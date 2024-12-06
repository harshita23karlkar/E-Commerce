import 'package:products/Shared_Preferances/shared_preferances.dart';

class UserCartModel {
  num totalAmmount = 0;
  void removeItemsFromCart(int id) async {
    var templist =
        await MySharedPreferances().getCartItemListFromLocalStorage();
    List<int> list = templist.map((e) => int.parse(e.toString())).toList();
    list.remove(id);
    await MySharedPreferances().saveCartItemListLocally(list);
  }
}
