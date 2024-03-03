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
  Duration? remainingTime;
  String? pickedPacketNo;
  String? hoursNum;
  bool checkoutForm=false;
  bool isRented1=false;
  bool isRented2=false;
  bool isRented3=false;
  bool isRented4=false;
  bool isRented5=false;
  bool isRented6=false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    setUsername();
    //getRemainingTime();

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where('id',
                whereIn: ['$email,$friendEmail', '$friendEmail,$email'])
            .orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  '$username',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: kPrimaryColor,
              ),
              body: Stack(
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
                                checkoutForm=true;
                              });
                            }, used: isRented1,
                          ),
                          CarPacket(
                            packetNum: Icons.looks_two_rounded,
                            onTap: () {
                              pickedPacketNo = '2';
                              setState(() {
                                checkoutForm=true;
                              });
                            }, used: isRented2,
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
                                checkoutForm=true;
                              });
                            }, used: isRented3,
                          ),
                          CarPacket(
                              packetNum: Icons.looks_4_rounded,
                              onTap: () {
                                pickedPacketNo = '4';
                                setState(() {
                                  checkoutForm=true;
                                });
                              }, used: isRented4,),
                        ],
                      ),
                      Row(
                        children: [
                          CarPacket(
                            packetNum: Icons.looks_5_rounded,
                            onTap: () {
                              pickedPacketNo = '5';
                              setState(() {
                                checkoutForm=true;
                              });
                            }, used: isRented5,
                          ),
                          CarPacket(
                            packetNum: Icons.looks_6_rounded,
                            onTap: () {
                              pickedPacketNo = '6';
                              setState(() {
                                checkoutForm=true;
                              });
                            }, used: isRented6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                      visible: checkoutForm,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            checkoutForm=false;
                          });
                        },
                        child: Container(
                          color: Colors.black54,

                        ),
                      )),
                  Visibility(
                    visible: checkoutForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 280, horizontal: 60),
                      child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                Text('Packet No.$pickedPacketNo',style: TextStyle(fontSize: 17),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 26),
                                  child: TextField(
                                    onChanged: (data){
                                      hoursNum = data;
                                    },
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: kPrimaryColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: kPrimaryColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),

                                    ),
                                  ),
                                ),
                                CustomButton2(text: 'Proceed', onTap: (){
                                  if(hoursNum!=null){
                                    garage.add({
                                      'time': DateTime.now().add(Duration(hours: int.parse(hoursNum!))).toString(),
                                      'id': pickedPacketNo,
                                    });
                                    if(pickedPacketNo=='1'){
                                      isRented1=true;
                                    }
                                    if(pickedPacketNo=='2'){
                                      isRented2=true;
                                    }
                                    if(pickedPacketNo=='3'){
                                      isRented3=true;
                                    }
                                    if(pickedPacketNo=='4'){
                                      isRented4=true;
                                    }
                                    if(pickedPacketNo=='5'){
                                      isRented5=true;
                                    }
                                    if(pickedPacketNo=='6'){
                                      isRented6=true;
                                    }
                                    checkoutForm=false;
                                    hoursNum=null;
                                  }
                                })
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: const Center(
                    child: Text(
                  'Loading..',
                  style: TextStyle(color: kPrimaryColor),
                )));
          }
        });
  }

  Future<void> setUsername() async {
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: email).get();

    username = await querySnapshot.docs.first["username"];
    setState(() {});
  }

  Future<void> getRemainingTime() async {
    QuerySnapshot querySnapshot = await garage.where('id', isEqualTo: 1).get();

    String? firebaseTime = await querySnapshot.docs.first["time"];
    DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
    DateTime currentTime = DateTime.now();
    remainingTime = endTime.difference(currentTime);

    setState(() {});
  }
}
