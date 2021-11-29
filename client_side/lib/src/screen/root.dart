import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Root extends GetView<AuthService> {
  const Root({Key? key}) : super(key: key);

  static const routeName = '/Root';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.loadUser(),
      builder: (context, snapshot) {
        if (controller.user != null) {
          return Container();
        }

        return LoginScreen();
      },
    );
  }
}
