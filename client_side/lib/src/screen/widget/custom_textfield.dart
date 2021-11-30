import 'package:client_side/src/utils/my_colors.dart';
import 'package:client_side/src/utils/validations.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icons,
    this.isSecure = false,
    this.inputType,
    this.validator,
    this.maxLines,
    this.maxlength,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData icons;
  final bool isSecure;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final int? maxLines;
  final int? maxlength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacity,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isSecure,
        keyboardType: inputType,
        validator: validator,
        // maxLines: maxLines ,
        // maxLength: maxlength,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          prefixIcon: Icon(
            icons,
            color: MyColors.primary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: MyColors.primaryDark),
        ),
      ),
    );
  }
}

class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacity,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        controller: controller,
        validator: validIsEmpty,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          suffixIcon: Icon(
            Icons.description,
            color: MyColors.primary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: MyColors.primaryDark),
        ),
      ),
    );
  }
}

class CircleImageButton extends StatelessWidget {
  const CircleImageButton({
    Key? key,
    required this.imageProvider,
    required this.onTap,
    this.width = 120,
    this.height = 120,
  }) : super(key: key);

  final ImageProvider<Object> imageProvider;

  final Function() onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: Ink.image(
        image: imageProvider,
        fit: BoxFit.cover,
        width: 120.0,
        height: 120.0,
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}
