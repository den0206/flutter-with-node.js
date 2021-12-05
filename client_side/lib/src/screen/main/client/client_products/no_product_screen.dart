import 'package:flutter/material.dart';

class NoProductScreen extends StatelessWidget {
  const NoProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_items.png"),
          Text("No Product")
        ],
      ),
    );
  }
}
