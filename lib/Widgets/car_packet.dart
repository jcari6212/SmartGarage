import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../constants.dart';



class CarPacket extends StatefulWidget {
  CarPacket({super.key, required this.packetNum});

  dynamic packetNum;

  @override
  State<CarPacket> createState() => _CarPacketState();
}

class _CarPacketState extends State<CarPacket> {
  bool used = false;

  //DateTime endTime = DateTime.now().add(const Duration(hours: 2));
  DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse('2024-3-3 23:59:59');

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    Duration remainingTime = endTime.difference(currentTime);
    return Padding(
      padding: const EdgeInsets.only(top: 58,left:  32),
      child: GestureDetector(
        onTap: (){
          setState(() {
            used = !used;
          });
        },
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              color: used? Colors.red : kPrimaryColor,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(used? Icons.lock_clock : widget.packetNum,size: 40,color: Colors.white,),
              Visibility(
                visible: used,
                child: SlideCountdown(
                  duration: remainingTime,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
