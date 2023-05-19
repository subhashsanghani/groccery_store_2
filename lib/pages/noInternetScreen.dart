import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';


class noInternetScreen extends StatelessWidget {
  const noInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/Icons/noNet.png" , height: 120, width: 130, alignment: Alignment.center,),

              SizedBox(height: 35,),

              myText(title:"No Internet Connection",
                fontSize: 28, fontWeight: FontWeight.w400, textColor: appColors.appOrange, ),

              SizedBox(height: 16,),

              SizedBox(
                width: MediaQuery.of(context).size.width/1.5,
                child: myText(title:"Your internet connection is currently not available please check or try again.",
                  fontSize: 17, fontWeight: FontWeight.w400, textColor: appColors.textBrown2, maxLines: 2, textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
