import 'package:flutter/material.dart';
import 'package:products/Provider/user_cart_provider.dart';
import 'package:products/networking/api_service.dart';
import 'package:provider/provider.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key});
  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<UserCartProvider>(
              builder: (context, value, child) => ListView.builder(
                itemCount: value.userCartItems?.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: ApiService()
                        .fetchProductWithId(value.userCartItems[index]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.data == null) {
                        return Text(snapshot.error.toString());
                      }
                      return ListTile(
                        leading: Image.network(snapshot.data!.image),
                        title: Text(snapshot.data!.title),
                        subtitle: Text("Price : ${snapshot.data!.price}"),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
