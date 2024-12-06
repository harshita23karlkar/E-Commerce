import 'package:flutter/material.dart';
import 'package:products/Provider/user_cart_provider.dart';
import 'package:products/Shared_Preferances/shared_preferances.dart';
import 'package:products/models/product_model.dart';
import 'package:products/screens/product_details.dart';
import 'package:provider/provider.dart';

class Productcontainer extends StatefulWidget {
  const Productcontainer({super.key});

  @override
  State<Productcontainer> createState() => _ProductcontainerState();
}

class _ProductcontainerState extends State<Productcontainer> {
  @override
  void initState() {
    context.read<UserCartProvider>().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserCartProvider>(
      builder: (context, value, child) {
        var products = value.products;
        if (products.isEmpty) {
          return Text("No Data");
        }
        return GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            var product = products[index];
            return Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    productId: product.id,
                                  ),
                                ));
                          },
                          child: Image.network(
                            product.image,
                            // height: 150,
                            width: double.maxFinite,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      product.title.substring(0, 13),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Price :",
                        children: [
                          TextSpan(
                            text: "${product.price}/-",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    //add to cart widget
                    AddToCartButton(product: product),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// add to cart

class AddToCartButton extends StatefulWidget {
  final ProductModel product;
  AddToCartButton({super.key, required this.product});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  MySharedPreferances myprf = MySharedPreferances();
  Widget build(BuildContext context) {
    return Consumer<UserCartProvider>(
      builder: (context, value, child) => TextButton(
        onPressed: () async {
          value.addToCartLocal(widget.product);
          print(value.userCartItems);
          await myprf.saveCartItemListLocally(value.userCartItems);
        },
        child: const Text(
          "Add To Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
