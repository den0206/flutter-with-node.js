import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/main/restaurant/categoey/category_create_controller.dart';
import 'package:client_side/src/screen/widget/custom_textfield.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CategoryCreateScreen extends GetView<CategoryCreateController> {
  CategoryCreateScreen({Key? key}) : super(key: key);

  static const routeName = '/CategoryCreate';
  final _formKey = GlobalKey<FormState>(debugLabel: '_crateCategiry');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextField(
                controller: controller.nameController,
                hintText: "Category Name",
                validator: validIsEmpty,
                icons: Icons.list_alt,
              ),
              CustomDescriptionField(
                controller: controller.descriptionController,
                hintText: "Create Description",
              ),
              AuthButton(
                title: "Create Category",
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    controller.createCategory();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
