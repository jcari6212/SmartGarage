import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../constants.dart';



class CarPacket extends StatefulWidget {
  CarPacket({super.key, required this.packetNum, required this.onTap,required this.used,this.remainingTime});

  dynamic packetNum;
  VoidCallback onTap;
  bool used = false;
  Duration? remainingTime;


  @override
  State<CarPacket> createState() => _CarPacketState();
}

class _CarPacketState extends State<CarPacket> {

  @override
  Widget build(BuildContext context) {

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
                  duration: widget.remainingTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
