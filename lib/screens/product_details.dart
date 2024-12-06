import 'package:flutter/material.dart';
import 'package:products/models/product_model.dart';
import 'package:products/networking/api_service.dart';
import 'package:products/screens/productsContainer.dart';

class ProductDetails extends StatefulWidget {
  int productId;
  ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person_outlined))
        ],
      ),
      body: FutureBuilder(
        future: ApiService().fetchProductWithId(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null) {
            return Text(snapshot.error.toString());
          }
          return Padding(
            padding: EdgeInsets.all(50),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[100],
                border: Border.all(
                    color: const Color.fromARGB(255, 202, 90, 184), width: 1),
              ),
              child: ListView(
                children: [
                  Container(
                    color: Colors.white,
                    child: Image.network(
                      snapshot.data!.image,
                      height: 250,
                      width: double.maxFinite,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Title : ${snapshot.data!.title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          "Description : ${snapshot.data!.description}",
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Price :",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "${snapshot.data!.price}/-",
                                  style: TextStyle(color: Colors.green),
                                )
                              ]),
                        ),
                        AddToCartButton(product: snapshot.data as ProductModel),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
