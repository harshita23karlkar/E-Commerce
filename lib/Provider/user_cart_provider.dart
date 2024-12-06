import 'package:flutter/material.dart';
import 'package:products/Shared_Preferances/shared_preferances.dart';
import 'package:products/models/product_model.dart';
import 'package:products/networking/api_service.dart';

class UserCartProvider extends ChangeNotifier {
  List<int> userCartItems =
      []; //Contains the product id that user has added in the cart
  List<ProductModel> products = []; //contains all the product list
  List<ProductModel> cartproducts =
      []; //list of the product data that user has added in the list

  void fetchProducts() async {
    products = await ApiService().fetchProduct();
    notifyListeners();
  }

  void addToCartLocal(ProductModel product) {
    bool isItemInCart = false;

    for (var e in cartproducts) {
      if (e.id == product.id) {
        isItemInCart = true;
        break;
      }
      ;
    }
    if (cartproducts.isEmpty || !isItemInCart) {
      cartproducts.add(product);
    } else {
      for (var e in cartproducts) {
        if (product.id == e.id) {
          product.quantity++;
        }
      }
    }
    notifyListeners();
  }

  // void addToCart(int productId) {
  //   if (!userCartItems.contains(productId)) userCartItems.add(productId);

  //   notifyListeners();
  // }

  // updateCart() async {
  //   List cartItemsId =
  //       await MySharedPreferances().getCartItemListFromLocalStorage();
  //   List<int> list = cartItemsId.map((e) => int.parse(e.toString())).toList();

  //   cartproducts.clear();
  //   for (int i = 0; i < list.length; i++) {
  //     int id = list[i];

  //     products.forEach((product) {
  //       if (product.id == id) {
  //         // product = product.copyWith(quantity: product.quantity++);
  //         cartproducts.add(product);
  //       }
  //     });
  //     // list[i];
  //   }
  //   notifyListeners();
  // }

  num getTotalPrice() {
    num totalAmmount = 0;

    for (int i = 0; i < cartproducts.length; i++) {
      totalAmmount =
          totalAmmount + cartproducts[i].price * cartproducts[i].quantity;
    }
    return totalAmmount;
  }
}
