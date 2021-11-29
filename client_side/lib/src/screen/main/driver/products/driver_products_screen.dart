import 'package:flutter/material.dart';

class DriverProductsScreen extends StatelessWidget {
  const DriverProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/driver_products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Text("Driver"),
      ),
    );
  }
}
