import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      this.onChanged,
      this.validator,
      this.isPassword = false});

  String? hintText;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: TextFormField(
        
        validator: validator,
        obscureText: isPassword,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
