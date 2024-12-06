// import 'package:flutter/material.dart';
// import 'package:products/Shared_Preferances/shared_preferances.dart';
// import 'package:products/models/user_cart_model.dart';
// import 'package:products/networking/api_service.dart';

// class UserCart2 extends StatefulWidget {
//   const UserCart2({super.key});
//   @override
//   State<UserCart2> createState() => _UserCartState();
// }

// // get cartItems List from provider
// class _UserCartState extends State<UserCart2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder(
//               future: MySharedPreferances().getCartItemListFromLocalStorage(),
//               builder: (context, snapshot) => ListView.builder(
//                 itemCount: snapshot.data?.length,
//                 itemBuilder: (context, index) {
//                   return FutureBuilder(
//                     future:
//                         ApiService().fetchProductWithId(snapshot.data![index]),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const CircularProgressIndicator();
//                       } else if (snapshot.data == null) {
//                         return Text(snapshot.error.toString());
//                       }
//                       return ListTile(
//                         leading: Image.network(snapshot.data!.image),
//                         title: Text(snapshot.data!.title),
//                         subtitle: Text("Price : ${snapshot.data!.price}"),
//                         trailing: IconButton(
//                             onPressed: () async {
//                               // Remove item from cart
//                               UserCartModel()
//                                   .removeItemsFromCart(snapshot.data!.id);
//                               setState(() {});
//                             },
//                             icon: const Icon(Icons.delete)),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:products/Provider/user_cart_provider.dart';
import 'package:products/Shared_Preferances/shared_preferances.dart';
import 'package:products/models/user_cart_model.dart';
import 'package:products/networking/api_service.dart';
import 'package:provider/provider.dart';

class UserCart2 extends StatefulWidget {
  const UserCart2({super.key});
  @override
  State<UserCart2> createState() => _UserCartState();
}

// get cartItems List from provider
class _UserCartState extends State<UserCart2> {
  @override
  void initState() {
    // context.read<UserCartProvider>().updateCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<UserCartProvider>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.cartproducts.length,
                itemBuilder: (context, index) {
                  var cartProduct = value.cartproducts[index];
                  return ListTile(
                    leading: Image.network(cartProduct.image),
                    isThreeLine: true,
                    title: Text(cartProduct.title),
                    subtitle: Text(
                        "Price : ${cartProduct.price}\n Quantity : ${cartProduct.quantity}"),
                    trailing: IconButton(
                        onPressed: () async {
                          // Remove item from cart
                          UserCartModel().removeItemsFromCart(cartProduct.id);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
              ),
            ),
          ),
          Text(context.watch<UserCartProvider>().getTotalPrice().toString())
        ],
      ),
    );
  }
}
