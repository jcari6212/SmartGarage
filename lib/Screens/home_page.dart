import 'package:flutter/material.dart';
import 'package:untitled/Widgets/custom_button.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome, Smart Garage',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 220,
              ),
              CustomButton(
                  text: 'Login',
                  onTap: () {
                    Navigator.pushNamed(context, 'loginPage');
                  }),
              CustomButton(
                  text: 'Register',
                  onTap: () {
                    Navigator.pushNamed(context, 'registerPage');
                  }),
            ],
          ),
        ),
      )
    );
  }
}
