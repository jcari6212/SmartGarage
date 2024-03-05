import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});

  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 92, vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(
                color: Color.fromARGB(255, 150, 147, 147),
                offset: Offset(-5.0,5.0),
                blurRadius: 20,
                spreadRadius: 0.5
            )]),
        width: double.infinity,
        height: 50,
        child: Center(
            child: Text(
          text!,
          style: const TextStyle(color: Color(0xff0047AB), fontSize: 18),
        )),
      ),
    );
  }
}
