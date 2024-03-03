import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:untitled/Models/message_model.dart';
import 'package:untitled/Widgets/custom_button.dart';
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



  String? textMessage;
  final textController = TextEditingController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getRemainingTime();
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


    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').where('id',
            whereIn: [
              '$email,$friendEmail',
              '$friendEmail,$email'
            ]).orderBy('time')
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
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
              body: Column(
                children: [
                  Row(
                    children: [
                      CarPacket(packetNum: Icons.looks_one_rounded),
                      CarPacket(packetNum: Icons.looks_two_rounded),
                    ],
                  ),
                  Row(
                    children: [
                      CarPacket(packetNum: Icons.looks_3_rounded),
                      CarPacket(packetNum: Icons.looks_4_rounded),
                    ],
                  ),
                  //Row(
                    //children: [
                      //CarPacket(packetNum: Icons.looks_5_rounded),
                      //CarPacket(packetNum: Icons.looks_6_rounded),
                    //],
                  //),
                  CustomButton(text: 'Press', onTap: (){
                    garage.add({
                      'time': DateTime.now().add(const Duration(hours: 2)),
                      'id': 1,
                    });
                  }),
                  SlideCountdown(
                    duration: remainingTime,
                  ),
                ],
              ),
            );
          }else{
            return Container(color: Colors.white,child: const Center(child: Text('Loading..',style: TextStyle(color: kPrimaryColor),)));
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
    QuerySnapshot querySnapshot =
    await garage.where('id', isEqualTo: 1).get();

    String? firebaseTime = await querySnapshot.docs.first["time"];
    DateTime endTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(firebaseTime!);
    DateTime currentTime = DateTime.now();
    remainingTime = endTime.difference(currentTime);


    setState(() {});
  }
}

