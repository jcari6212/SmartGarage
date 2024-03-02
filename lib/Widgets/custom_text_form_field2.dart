import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

class CustomTextFormField2 extends StatelessWidget {
  CustomTextFormField2(
      {super.key,
      required this.hintText,
        this.textIcon,
      this.onChanged,
      this.validator,
      this.isPassword = false,
      });

  String? hintText;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool isPassword;
  Icon? textIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: TextFormField(

        validator: validator,
        obscureText: isPassword,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: textIcon,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
