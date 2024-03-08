import 'package:flutter/material.dart';

import '../constants.dart';




class PayButtom extends StatelessWidget {
  const PayButtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pay',style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold),),
          SizedBox(width: 12,),
          Icon(Icons.arrow_forward,size: 18,color: kPrimaryColor,)
        ],
      ),
    );
  }
}
