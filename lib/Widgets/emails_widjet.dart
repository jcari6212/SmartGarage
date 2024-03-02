import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

class EmailsWidget extends StatelessWidget {
  String? chattedEmail;
  String? email;
  VoidCallback? onTap;

  EmailsWidget({super.key, this.chattedEmail,this.onTap,this.email});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kThirdColor,
          borderRadius: BorderRadius.circular(16)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 2),
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        child: Text(
          chattedEmail! == email ? '$chattedEmail (You)' : '$chattedEmail',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
