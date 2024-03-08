import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Screens/garage_page.dart';
import 'package:untitled/Screens/home_page.dart';
import 'package:untitled/Screens/login_page.dart';
import 'package:untitled/Screens/rent_page.dart';
import 'Screens/payment_page.dart';
import 'firebase_options.dart';
import 'Screens/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'homePage',
    routes: {
      'homePage': (context) => const HomePage(),
      'loginPage': (context) => LoginPage(),
      'registerPage': (context) => RegisterPage(),
      'chatPage': (context) => ChatPage(),
      'rentPage': (context) => RentPage(),
      'paymentPage': (context) => PaymentPage(),
    },
  ));


}
