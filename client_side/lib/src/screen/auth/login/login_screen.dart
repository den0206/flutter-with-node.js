import 'package:client_side/src/screen/auth/regstration/registration_screen.dart';
import 'package:client_side/src/utils/my_colors.dart';
import 'package:client_side/src/screen/widget/custom_textfield.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/Login';
  final _formKey = GlobalKey<FormState>(debugLabel: '_LoginState');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        _loginCircle(),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              lottieAnimation(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.emailController,
                      hintText: "Email",
                      icons: Icons.email,
                      validator: validateEmail,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    CustomTextField(
                      controller: controller.passwordController,
                      hintText: "Password",
                      icons: Icons.password,
                      isSecure: true,
                      validator: validPassword,
                    ),
                    AuthButton(
                      title: "Login",
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          await controller.login();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not yet",
                    style: TextStyle(
                      color: MyColors.primary,
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  TextButton(
                    child: Text(
                      "Register?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: MyColors.primary,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(RegistrationScreen.routeName);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }

  Widget lottieAnimation() {
    return Lottie.asset('assets/json/delivery.json',
        width: 350, height: 200, fit: BoxFit.fill);
  }

  Container test_logo(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            top: 100, bottom: MediaQuery.of(context).size.height * 0.1),
        child:
            Image.asset("assets/images/delivery.png", width: 200, height: 200));
  }

  Widget _loginCircle() {
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
        Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        )
      ],
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        child: Text(title),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            primary: MyColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
        onPressed: onPress,
      ),
    );
  }
}
