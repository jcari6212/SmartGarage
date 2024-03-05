import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  CollectionReference garage = FirebaseFirestore.instance.collection('garage');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? email;
  String? username = '';


  @override
  Widget build(BuildContext context) {
    email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    setUsername();

    var period = const Duration(seconds: 1);
    Timer.periodic(period, (arg) async {
      setState(() {
        checkIfStillRenting();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$username',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: Center(
          child: Text(
            'Your are parking at packet no.1',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Future<void> checkIfStillRenting() async {
    QuerySnapshot querySnapshot1 = await garage.where('email', isEqualTo: email).get();
    if(querySnapshot1.docs.isEmpty){
      Navigator.pushNamed(context, 'chatPage',
          arguments: email);
    }
  }

  Future<void> setUsername() async {
    QuerySnapshot querySnapshot =
    await users.where('email', isEqualTo: email).get();

    username = await querySnapshot.docs.first["username"];
    setState(() {});
  }
}
