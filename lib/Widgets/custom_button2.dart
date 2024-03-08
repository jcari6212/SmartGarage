import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

class CustomButton2 extends StatelessWidget {
  const CustomButton2({super.key, required this.text, required this.onTap});

  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 92, vertical: 6),
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(36),
            boxShadow: [BoxShadow(
              color: kPrimaryColor!,
              blurRadius: 0.0,
              spreadRadius: 3.0,

            )]
        ),
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text(
          text!,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        )),
      ),
    );
  }
}
