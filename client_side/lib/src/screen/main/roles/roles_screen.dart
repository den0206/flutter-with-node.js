import 'package:client_side/src/model/role.dart';
import 'package:client_side/src/screen/main/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class RolesScreen extends GetView<RolesConstroller> {
  const RolesScreen({Key? key}) : super(key: key);
  static const routeName = '/roles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: controller.user.roles?.length,
          itemBuilder: (BuildContext context, int index) {
            final role = controller.user.roles?[index];
            if (role == null) return Container();
            return RoleCard(role: role);
          },
        ),
      ),
    );
  }
}

class RoleCard extends GetView<RolesConstroller> {
  const RoleCard({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.goToPage(role);
      },
      child: Column(
        children: [
          Container(
            height: 100,
            child: FadeInImage(
              image: NetworkImage("https://picsum.photos/250?image=9"),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage("assets/images/no-image.jpg"),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            role.name,
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
