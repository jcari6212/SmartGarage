import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../constants.dart';



class CarPacket extends StatefulWidget {
  CarPacket({super.key, required this.packetNum, required this.onTap,required this.used});

  dynamic packetNum;
  VoidCallback onTap;
  bool used = false;


  @override
  State<CarPacket> createState() => _CarPacketState();
}

class _CarPacketState extends State<CarPacket> {
  CollectionReference garage = FirebaseFirestore.instance.collection('garage');

  Duration? remainingTime1;
  Duration? remainingTime2;
  Duration? remainingTime3;
  Duration? remainingTime4;
  Duration? remainingTime5;
  Duration? remainingTime6;



  @override
  Widget build(BuildContext context) {

    getRemainingTime();
    return Padding(
      padding: const EdgeInsets.only(top: 58,left:  32),
      child: GestureDetector(
        onTap: widget.used? (){} :widget.onTap,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: widget.used? Colors.red : kPrimaryColor,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.used? Icons.lock_clock : widget.packetNum,size: 40,color: Colors.white,),
              Visibility(
                visible: widget.used,
                child: SlideCountdown(
                  duration: Duration(hours: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getRemainingTime() async {
    QuerySnapshot querySnapshot1 = await garage.where('id', isEqualTo: 1).get();
    if(querySnapshot1.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot1.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }

    QuerySnapshot querySnapshot2 = await garage.where('id', isEqualTo: 2).get();
    if(querySnapshot2.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot2.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }

    QuerySnapshot querySnapshot3 = await garage.where('id', isEqualTo: 3).get();
    if(querySnapshot3.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot3.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }

    QuerySnapshot querySnapshot4 = await garage.where('id', isEqualTo: 4).get();
    if(querySnapshot4.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot4.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }

    QuerySnapshot querySnapshot5 = await garage.where('id', isEqualTo: 5).get();
    if(querySnapshot5.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot5.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }

    QuerySnapshot querySnapshot6 = await garage.where('id', isEqualTo: 6).get();
    if(querySnapshot6.docs.isNotEmpty){
      String? firebaseTime = await querySnapshot6.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      remainingTime1 = endTime.difference(currentTime);
    }


  }
}
