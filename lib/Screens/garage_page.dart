import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Models/message_model.dart';
import 'package:untitled/Widgets/custom_button.dart';
import 'package:untitled/Widgets/custom_button2.dart';
import 'package:untitled/Widgets/custom_text_field.dart';
import 'package:untitled/constants.dart';
import 'dart:async';
import '../Widgets/car_packet.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  CollectionReference garage = FirebaseFirestore.instance.collection('garage');
  CollectionReference online = FirebaseFirestore.instance.collection('online');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) return;

    final inactive = state == AppLifecycleState.inactive;
    final detached = state == AppLifecycleState.detached;
    final resumed = state == AppLifecycleState.resumed;

    if (inactive) {
      QuerySnapshot querySnapshot =
      await online.where('id', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
      }
    } else if (resumed) {
      online.add({
        'id': email,
      });
    } else {
      QuerySnapshot querySnapshot =
      await online.where('id', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
      }
    }
  }

  GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? username = '';
  String? friendEmail = '';

  String? pickedPacketNo;
  String? hoursNum;
  bool checkoutForm = false;
  bool isRented1 = false;
  bool isRented2 = false;
  bool isRented3 = false;
  bool isRented4 = false;
  bool isRented5 = false;
  bool isRented6 = false;
  Duration? remainingTime1;
  Duration? remainingTime2;
  Duration? remainingTime3;
  Duration? remainingTime4;
  Duration? remainingTime5;
  Duration? remainingTime6;


  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    var period = const Duration(seconds: 1);
    Timer.periodic(period, (arg) async {
      getRemainingTime1();
      getRemainingTime2();
      getRemainingTime3();
      getRemainingTime4();
      getRemainingTime5();
      getRemainingTime6();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    setUsername();



    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$username',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(height: 80,width: double.infinity,decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
          ),child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('There are 6 places left',style: TextStyle(color: Colors.white,fontSize: 18),),
              SizedBox(width: 30,),
              CircularProgressIndicator(color: Colors.white,value: 0.0,backgroundColor: Colors.white38,)
            ],
          ),),
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              CarPacket(
                                packetNum: Icons.looks_one_rounded,
                                onTap: () {
                                  pickedPacketNo = '1';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented1,
                                remainingTime: isRented1 ? remainingTime1 : Duration(seconds: 1),
                              ),
                              CarPacket(
                                packetNum: Icons.looks_two_rounded,
                                onTap: () {
                                  pickedPacketNo = '2';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented2,
                                remainingTime: isRented2 ? remainingTime2 : Duration(
                                    seconds: 1),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CarPacket(
                                packetNum: Icons.looks_3_rounded,
                                onTap: () {
                                  pickedPacketNo = '3';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented3,
                                remainingTime: isRented3? remainingTime3 : Duration(hours: 1),
                              ),
                              CarPacket(
                                packetNum: Icons.looks_4_rounded,
                                onTap: () {
                                  pickedPacketNo = '4';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented4,
                                remainingTime: isRented4 ? remainingTime4 : Duration(
                                    seconds: 1),
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              CarPacket(
                                packetNum: Icons.looks_5_rounded,
                                onTap: () {
                                  pickedPacketNo = '5';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented5,
                                remainingTime: isRented5 ? remainingTime5 : Duration(
                                    seconds: 1),
                              ),
                              CarPacket(
                                packetNum: Icons.looks_6_rounded,
                                onTap: () {
                                  pickedPacketNo = '6';
                                  setState(() {
                                    checkoutForm = true;
                                  });
                                }, used: isRented6,
                                remainingTime: isRented6 ? remainingTime6 : Duration(
                                    seconds: 1),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      Visibility(
                          visible: checkoutForm,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                checkoutForm = false;
                              });
                            },
                            child: Container(
                              height: 1050,
                              color: Colors.black54,
                            ),
                          )),
                      Visibility(
                        visible: checkoutForm,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 280, horizontal: 60),
                          child: SingleChildScrollView(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  Text('Packet No.$pickedPacketNo',
                                    style: TextStyle(fontSize: 17),),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 26),
                                    child: TextField(
                                      onChanged: (data) {
                                        hoursNum = data;
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kPrimaryColor!),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kPrimaryColor!),
                                          borderRadius: BorderRadius.circular(12),
                                        ),

                                      ),
                                    ),
                                  ),
                                  CustomButton2(text: 'Proceed', onTap: () {
                                    if (hoursNum != null) {
                                      garage.add({
                                        'email': email,
                                        'id': pickedPacketNo,
                                        'time': DateTime.now()
                                            .add(Duration(hours: int.parse(hoursNum!)))
                                            .toString(),
                                      });
                                      if (pickedPacketNo == '1') {
                                        getRemainingTime1();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      if (pickedPacketNo == '2') {
                                        getRemainingTime2();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      if (pickedPacketNo == '3') {
                                        getRemainingTime3();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      if (pickedPacketNo == '4') {
                                        getRemainingTime4();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      if (pickedPacketNo == '5') {
                                        getRemainingTime5();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      if (pickedPacketNo == '6') {
                                        getRemainingTime6();
                                        Navigator.pushNamed(context, 'rentPage',
                                            arguments: email);
                                      }
                                      checkoutForm = false;
                                      hoursNum = null;
                                    }
                                  })
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Future<void> setUsername() async {
    QuerySnapshot querySnapshot =
    await users.where('email', isEqualTo: email).get();

    username = await querySnapshot.docs.first["username"];
    setState(() {});
  }


  Future<void> getRemainingTime1() async {
    QuerySnapshot querySnapshot1 = await garage.where('id', isEqualTo: '1').get();
    if (querySnapshot1.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot1.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime1 = endTime.difference(currentTime);
      });
      setState(() {
        isRented1 = true;
      });
        if(endTime.isBefore(DateTime.now())){
          await querySnapshot1.docs.first.reference.delete();
        }
    }else{
      isRented1=false;
    }
  }

  Future<void> getRemainingTime2() async {
    QuerySnapshot querySnapshot2 = await garage.where('id', isEqualTo: '2').get();
    if (querySnapshot2.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot2.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime2 = endTime.difference(currentTime);
      });
      setState(() {
        isRented2 = true;
      });
      if(endTime.isBefore(DateTime.now())){
        await querySnapshot2.docs.first.reference.delete();
      }
    }else{
      isRented2=false;
    }
  }

  Future<void> getRemainingTime3() async {
    QuerySnapshot querySnapshot3 = await garage.where('id', isEqualTo: '3').get();
    if (querySnapshot3.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot3.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime3 = endTime.difference(currentTime);
      });
      setState(() {
        isRented3 = true;
      });
      if(endTime.isBefore(DateTime.now())){
        await querySnapshot3.docs.first.reference.delete();
      }
    }else{
      isRented3=false;
    }
  }

  Future<void> getRemainingTime4() async {
    QuerySnapshot querySnapshot4 = await garage.where('id', isEqualTo: '4').get();
    if (querySnapshot4.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot4.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime4 = endTime.difference(currentTime);
      });
      setState(() {
        isRented4 = true;
      });
      if(endTime.isBefore(DateTime.now())){
        await querySnapshot4.docs.first.reference.delete();
      }
    }else{
      isRented4=false;
    }
  }

  Future<void> getRemainingTime5() async {
    QuerySnapshot querySnapshot5 = await garage.where('id', isEqualTo: '5').get();
    if (querySnapshot5.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot5.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime5 = endTime.difference(currentTime);
      });
      setState(() {
        isRented5 = true;
      });
      if(endTime.isBefore(DateTime.now())){
        await querySnapshot5.docs.first.reference.delete();
      }
    }else{
      isRented5=false;
    }
  }

  Future<void> getRemainingTime6() async {
    QuerySnapshot querySnapshot6 = await garage.where('id', isEqualTo: '6').get();
    if (querySnapshot6.docs.isNotEmpty) {
      String? firebaseTime = await querySnapshot6.docs.first["time"];
      DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
      DateTime currentTime = DateTime.now();
      setState(() {
        remainingTime6 = endTime.difference(currentTime);
      });
      setState(() {
        isRented6 = true;
      });
      if(endTime.isBefore(DateTime.now())){
        await querySnapshot6.docs.first.reference.delete();
      }
    }else{
      isRented6=false;
    }
  }



}
