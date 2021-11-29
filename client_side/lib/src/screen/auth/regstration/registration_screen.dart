import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/auth/regstration/registration_controller.dart';

import 'package:client_side/src/screen/widget/custom_textfield.dart';
import 'package:client_side/src/utils/my_colors.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  RegistrationScreen({Key? key}) : super(key: key);

  static const routeName = '/SignUP';
  final _formKey = GlobalKey<FormState>(debugLabel: '_SignUpState');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120, bottom: 50),
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/user_profile.png"),
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.emailTextController,
                          hintText: "Email",
                          icons: Icons.email,
                          validator: validateEmail,
                        ),
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
                        CustomTextField(
                          controller: controller.passwordTextController,
                          hintText: "Password",
                          icons: Icons.lock,
                          isSecure: true,
                          validator: validPassword,
                        ),
                        CustomTextField(
                          controller:
                              controller.passwordConfirmationTextController,
                          hintText: "Pasword Confirmation",
                          icons: Icons.lock_clock_outlined,
                          isSecure: true,
                          validator: validPassword,
                        ),
                        AuthButton(
                          title: "Sign Up",
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              await controller.registration();
                            }
                          },
                        )
                      ],
                    )),
              ],
            ),
          ),
          _registCircle(),
        ],
      ),
    );
  }

  Widget _registCircle() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
            color: MyColors.primary,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () {
                print("Call");
                Get.back();
              },
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// CircleImageButton(
//                     imageProvider:
//                         Image.asset("assets/images/add_image.png").image,
//                     onTap: () {},
//                   ),