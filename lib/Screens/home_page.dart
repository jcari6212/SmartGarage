import 'package:flutter/material.dart';
import 'package:untitled/Widgets/custom_button.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 380,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Bg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                boxShadow: [BoxShadow(
                    color: Color.fromARGB(255, 150, 147, 147),
                    offset: Offset(-5.0,5.0),
                    blurRadius: 20,
                    spreadRadius: 0.5
                )]
            ),

          ),
          Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Text(
                'Smart Garage',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 140,
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
              SizedBox(height: 50,)
            ],

          ),
        ],
      )
    );
  }
}
