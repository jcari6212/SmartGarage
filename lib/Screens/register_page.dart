import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/custom_text_form_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? username;
  String? email;
  String? password;
  String? cPassword;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            const Center(
                child: Image(
              image: AssetImage('assets/register.png'),
              width: 200,
              height: 200,
            )),
            CustomTextFormField(
              hintText: 'Username',
              onChanged: (data) {
                username = data;
              },
              validator: (data) {
                if (data!.isEmpty) {
                  return 'Please Enter Your Username';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              hintText: 'Email',
              onChanged: (data) {
                email = data;
              },
              validator: (data) {
                if (data!.isEmpty) {
                  return 'Please Enter Your Email';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              hintText: 'Password',
              isPassword: true,
              onChanged: (data) {
                password = data;
              },
              validator: (data) {
                if (data!.isEmpty) {
                  return 'Please Enter Password';
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              hintText: 'Confirm Password',
              isPassword: true,
              onChanged: (data) {
                cPassword = data;
              },
              validator: (data) {
                if (data!.isEmpty) {
                  return 'Please Confirm Your Password';
                } else if (password != cPassword) {
                  return 'Password Not Match';
                } else {
                  return null;
                }
              },
            ),
            CustomButton(
                text: 'Register',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      UserCredential user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email!, password: password!);
                      users.add({
                        'username': username,
                        'email': email,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Success')));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'loginPage');
                    },
                    child: const Text(
                      '  Login',
                      style: TextStyle(
                        color: kSecondColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
