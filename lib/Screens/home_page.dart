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
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              image: DecorationImage(
                image: AssetImage('assets/International.png'),
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
            child: Padding(
              padding: const EdgeInsets.only(top: 190),
              child: Center(
                child: Text(
                  'Smart Garage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
            ),

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
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
        ],
      )
    );
  }
}
