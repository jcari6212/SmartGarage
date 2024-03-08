import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:untitled/Widgets/custom_button.dart';
import 'package:untitled/Widgets/custom_button2.dart';
import 'package:untitled/Widgets/custom_text_field.dart';
import 'package:untitled/constants.dart';

import '../shared_data.dart';


class PaymentPage extends StatelessWidget {
   PaymentPage({super.key});
   CollectionReference garage = FirebaseFirestore.instance.collection('garage');

  String? cardNum;
  String? expiryDate;
  String? cvv;
  String? nameOnCard;
   String? email;

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the desired color here
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: Text(
              'Add Payment Method',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Stack(
        children: [
          Container(
            color: kPrimaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 190),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
              ),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 65,left: 22),
                        child: Text('Card Number',style: TextStyle(fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 22,right: 34),
                        child: TextField(
                          onChanged: (data) {
                            cardNum=data;

                          },
                          decoration: InputDecoration(
                            hintText: ' 1234 4322 5865 4525',
                            fillColor: Color(0xffeeeeee),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffeeeeee)),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffeeeeee)),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25,left: 22),
                        child: Row(
                          children: [
                            Text('Expiry Date',style: TextStyle(fontSize: 16),),
                            SizedBox(width: 110,),
                            Text('CVV',style: TextStyle(fontSize: 16),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 22,right: 34),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (data) {

                                  expiryDate=data;
                                },
                                decoration: InputDecoration(
                                  hintText: ' 09/27',
                                  fillColor: Color(0xffeeeeee),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeeeeee)),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeeeeee)),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 22,),
                            Expanded(
                              child: TextField(
                                onChanged: (data) {

                                  cvv=data;
                                },
                                decoration: InputDecoration(
                                  hintText: ' 105',
                                  fillColor: Color(0xffeeeeee),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeeeeee)),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffeeeeee)),
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25,left: 22),
                        child: Text('Name on card',style: TextStyle(fontSize: 16),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 22,right: 34),
                        child: TextField(
                          onChanged: (data) {

                            nameOnCard=data;
                          },
                          decoration: InputDecoration(
                            hintText: ' Islam Yasser',
                            fillColor: Color(0xffeeeeee),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffeeeeee)),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffeeeeee)),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      CustomButton2(text: 'Proceed', onTap: (){
                        if(cardNum == '4223223710203040' && expiryDate== '09/27' && cvv == '060'){
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            text: 'Transaction Completed Successfully!',
                          );
                          garage.add({
                            'email': email,
                            'id': SharedData.pickedPacketNo,
                            'time': DateTime.now()
                                .add(Duration(
                                hours:
                                int.parse(SharedData.secondHoursNum!)))
                                .toString(),
                          });
                          Future.delayed(Duration(seconds: 3), () async{
                            Navigator.pushNamed(
                                context, 'rentPage',
                                arguments: email);
                          });
                        }else{
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: 'Oops...',
                            text: 'Sorry, your card information is incorrect',
                          );
                        }


                      })
                    ],
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
