import 'package:flutter/material.dart';
import 'package:products/networking/api_service.dart';

class Categaries extends StatefulWidget {
  const Categaries({super.key});

  @override
  State<Categaries> createState() => _CategariesState();
}

class _CategariesState extends State<Categaries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().fetchCategaries(),
      builder: (context, snapshot) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(6),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.pink[300]),
                  child: Text(
                    snapshot.data![index],
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
