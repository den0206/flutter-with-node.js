import 'dart:io';

import 'package:client_side/src/model/category.dart';
import 'package:client_side/src/screen/auth/login/login_screen.dart';
import 'package:client_side/src/screen/main/restaurant/categoey/product/product_create_controller.dart';
import 'package:client_side/src/screen/widget/custom_textfield.dart';
import 'package:client_side/src/utils/my_colors.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductCreateScreen extends GetView<ProductCreateController> {
  ProductCreateScreen({Key? key}) : super(key: key);
  static const routeName = '/ProductCreate';
  final _formKey = GlobalKey<FormState>(debugLabel: '_crateProduct');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextField(
                  controller: controller.nameController,
                  hintText: "Product Name",
                  validator: validIsEmpty,
                  icons: Icons.list_alt,
                ),
                CustomDescriptionField(
                  controller: controller.descriptionController,
                  hintText: "Create Description",
                ),
                CustomTextField(
                  controller: controller.priceController,
                  hintText: "Price",
                  inputType: TextInputType.phone,
                  validator: validIsEmpty,
                  icons: Icons.monetization_on,
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _cardImage(null, 1, context),
                      _cardImage(null, 2, context),
                      _cardImage(null, 3, context),
                    ],
                  ),
                ),
                _dropdownCategories(),
                AuthButton(
                  title: "Create Category",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      controller.createProduct();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardImage(File? imageFile, int numberFile, BuildContext context) {
    return imageFile != null
        ? Card(
            elevation: 3.0,
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Image.file(
                imageFile,
                fit: BoxFit.cover,
              ),
            ),
          )
        : Card(
            elevation: 3.0,
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Image.asset(
                "assets/images/add_image.png",
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget _dropdownCategories() {
    return GetBuilder<ProductCreateController>(
      builder: (_) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 35),
          child: Material(
            elevation: 2.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.search, color: Colors.white),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Categories",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ))
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton(
                      elevation: 3,
                      underline: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_drop_down_circle,
                            color: MyColors.primary),
                      ),
                      isExpanded: true,
                      hint: Text(
                        "Select Category",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      value: controller.selectCategory,
                      items: controller.categoryItems,
                      onChanged: (Category? value) {
                        controller.onChange(value);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
