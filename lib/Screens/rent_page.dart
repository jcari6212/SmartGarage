import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../Widgets/custom_button2.dart';
import '../constants.dart';
import 'package:firebase_database/firebase_database.dart';

class RentPage extends StatefulWidget {
  RentPage({super.key});

  bool activeSlideDown = false;

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  CollectionReference garage = FirebaseFirestore.instance.collection('garage');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  String? email;
  String? username = '';
  Duration? remainingTime;
  String usedPacketNum = ' ';
  var packetStatus = 0;

  @override
  initState() {
    super.initState();
    DatabaseReference slotRef = FirebaseDatabase.instance.ref('slot');
    slotRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as int;
      setState(() {
        packetStatus = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    setUsername();
    var period = const Duration(seconds: 1);

    Timer.periodic(period, (arg) async {
      QuerySnapshot querySnapshot =
          await garage.where('email', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        String? firebaseTime = await querySnapshot.docs.first["time"];
        DateTime endTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
        DateTime currentTime = DateTime.now();
        remainingTime = endTime.difference(currentTime);
        setState(() {
          widget.activeSlideDown = true;
        });
        usedPacketNum = await querySnapshot.docs.first["id"];
      }
    });

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the desired color here
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: Text(
              '$username',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Center(
              child: Text(
                'Your are parking at packet no.$usedPacketNum',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remaining Time: ',
                      style: TextStyle(fontSize: 19),
                    ),
                    Visibility(
                      visible: widget.activeSlideDown,
                      child: SlideCountdown(
                        duration: widget.activeSlideDown
                            ? remainingTime
                            : Duration(seconds: 5),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                CustomButton2(
                  text: 'Cancel my rent',
                  onTap: () async {
                    QuerySnapshot querySnapshot =
                        await garage.where('email', isEqualTo: email).get();
                    await querySnapshot.docs.first.reference.delete();
                    setState(() {
                      widget.activeSlideDown = false;
                    });
                    DatabaseReference ref =
                        FirebaseDatabase.instance.ref("slot");
                    ref.set(0);
                    Navigator.pushNamed(context, 'chatPage', arguments: email);
                  },
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(20),
                  color: (packetStatus != 0) ? Colors.green : Colors.red,
                  child: Center(
                    child: Text(
                      (packetStatus != 0)
                          ? 'The packet still empty'
                          : 'Your car has been parked',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> initializing() async {}

  Future<void> setUsername() async {
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: email).get();

    username = await querySnapshot.docs.first["username"];
    setState(() {});
  }
}
