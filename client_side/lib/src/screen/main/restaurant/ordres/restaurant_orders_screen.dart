import 'package:flutter/material.dart';

class RestaurantOrdersScreen extends StatelessWidget {
  const RestaurantOrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/restaurant_orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Text("Orders"),
      ),
    );
  }
}
