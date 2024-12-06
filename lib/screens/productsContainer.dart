import 'package:flutter/material.dart';
import 'package:products/networking/api_service.dart';
import 'package:products/screens/product_details.dart';

class Productcontainer extends StatefulWidget {
  const Productcontainer({super.key});

  @override
  State<Productcontainer> createState() => _ProductcontainerState();
}

class _ProductcontainerState extends State<Productcontainer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == null) {
          return Text(snapshot.error.toString());
        }
        return GridView.builder(
          itemCount: snapshot.data?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
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
                                    productId: snapshot.data![index].id,
                                  ),
                                ));
                          },
                          child: Image.network(
                            snapshot.data![index].image,
                            // height: 150,
                            width: double.maxFinite,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      snapshot.data![index].title.substring(0, 13),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Price :",
                        children: [
                          TextSpan(
                            text: "${snapshot.data![index].price}/-",
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    //
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Add To Cart",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
