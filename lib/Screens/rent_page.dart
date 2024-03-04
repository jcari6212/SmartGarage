import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  CollectionReference garage = FirebaseFirestore.instance.collection('garage');


  String? email;


  @override
  Widget build(BuildContext context) {
    email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;

    var period = const Duration(seconds: 1);
    Timer.periodic(period, (arg) async {
      setState(() {
        checkIfStillRenting();
      });
    });

    return Container(
      color: Colors.red,
    );
  }

  Future<void> checkIfStillRenting() async {
    QuerySnapshot querySnapshot1 = await garage.where('email', isEqualTo: email).get();
    if(querySnapshot1.docs.isEmpty){
      Navigator.pushNamed(context, 'chatPage',
          arguments: email);
    }
  }
}
