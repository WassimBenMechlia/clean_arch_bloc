import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class Inputs extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final ValidationBuilder? validator;
  final bool obscure;
  final bool? readOnly;
  final String? errorText;
  final String? placeholder;
  final String? hintText;

  const Inputs(
      {Key? key,
      required this.controller,
      this.icon,
      this.validator,
      required this.obscure,
      this.errorText,
      this.placeholder,
      this.readOnly,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double avatarRadius = 10.0;

    return TextFormField(
      validator: validator?.build(),
      controller: controller,
      obscureText: obscure,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.5, color: const Color.fromARGB(255, 180, 180, 180)),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: avatarRadius, // Set the radius of the CircleAvatar
              backgroundColor: Colors.grey[300],
              child: Icon(
                icon,
                size: 20, // Adjust the size of the icon here
              ),
            ),
          ),
          errorText: errorText,
          labelStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            height: 0,
            color: Colors.grey[400], // Set the color to a lighter grey
          ),
          //labelText: placeholder,
          hintStyle: TextStyle(
            color:
                Colors.grey[400], // Set the desired color for the placeholder
          ),
          hintText: hintText),
    );
  }
}
