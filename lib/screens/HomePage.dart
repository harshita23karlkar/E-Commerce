import 'package:flutter/material.dart';
import 'package:products/screens/Login.dart';
import 'package:products/screens/categaries.dart';
import 'package:products/screens/productsContainer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              icon: Icon(Icons.person_outlined))
        ],
      ),
      body: const Column(
        children: [
          // Categaries(),
          Expanded(
            child: Productcontainer(),
          ),
        ],
      ),
    );
  }
}
