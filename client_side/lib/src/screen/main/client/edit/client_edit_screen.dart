import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/main/client/edit/client_edit_controller.dart';
import 'package:client_side/src/screen/widget/custom_textfield.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ClientEditScreen extends GetView<ClientEditController> {
  ClientEditScreen({Key? key}) : super(key: key);
  static const routeName = '/ClientEdit';
  final _formKey = GlobalKey<FormState>(debugLabel: '_ClientEditState');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120, bottom: 50),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user_profile.png"),
                radius: 60,
                backgroundColor: Colors.grey[200],
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameTextController,
                      hintText: "First Name",
                      icons: Icons.person,
                      validator: valideName,
                    ),
                    CustomTextField(
                      controller: controller.lastNameTextController,
                      hintText: "Last Name",
                      icons: Icons.person_outline,
                      validator: valideName,
                    ),
                    CustomTextField(
                      controller: controller.phoneTextController,
                      hintText: "phone",
                      inputType: TextInputType.phone,
                      icons: Icons.phone,
                      validator: validPhone,
                    ),
                    AuthButton(
                      title: "Edit",
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller.updateuser();
                        }
                      },
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
