import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Widgets/custom_button.dart';
import 'package:untitled/constants.dart';
import '../Widgets/custom_text_form_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String? email, password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 140),
          children: [
            const Center(
                child: Image(
              image: AssetImage('assets/enter.png'),
              width: 200,
              height: 200,
            )),
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
                  return 'Please Enter Your Password';
                } else {
                  return null;
                }
              },
            ),
            CustomButton(
                text: 'Login',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      UserCredential user = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email!, password: password!);

                      Navigator.pushNamed(context, 'chatPage',
                          arguments: email);

                      fillOnlineMap();
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
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'registerPage');
                    },
                    child: const Text(
                      '  Register',
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

  Future<void> fillOnlineMap() async {
    CollectionReference online = FirebaseFirestore.instance.collection('online');

    QuerySnapshot querySnapshot = await online
        .where('id', isEqualTo: email)
        .get();
    if (querySnapshot.docs.isEmpty) {
      online.add({
        'id': email,
      });
    }


  }
}
