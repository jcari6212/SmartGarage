import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
        this.textIcon,
      this.onChanged,
      this.isPassword = false,
      this.onSubmitted,
      this.onTap,this.textController});

  String? hintText;
  Function(String)? onChanged;
  bool isPassword;
  Icon? textIcon;
  Function(String)? onSubmitted;
  VoidCallback? onTap;
  final textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 24),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(onTap: onTap,child: textIcon),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor!),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor!),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
