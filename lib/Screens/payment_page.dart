import 'package:flutter/material.dart';
import 'package:untitled/Widgets/custom_text_field.dart';
import 'package:untitled/constants.dart';


class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 160),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70,left: 22),
                    child: Text('Card Number',style: TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 22,right: 34),
                    child: TextField(
                      onChanged: (data) {

                      },
                      decoration: InputDecoration(
                        hintText: '1234 4322 5865 4525',
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
                    padding: const EdgeInsets.only(top: 20,left: 22),
                    child: Text('Expiry Date',style: TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 22,right: 200),
                    child: TextField(
                      onChanged: (data) {

                      },
                      decoration: InputDecoration(
                        hintText: '       09/27',
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
          ),
        ],
      ),
    );
  }
}
