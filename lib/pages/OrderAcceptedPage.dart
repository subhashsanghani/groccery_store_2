import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';

import 'OrdersPage.dart';
import '../Components/ColorsFile.dart';

class OrderAccepted extends StatefulWidget {
  const OrderAccepted({Key? key}) : super(key: key);

  @override
  State<OrderAccepted> createState() => _OrderAcceptedState();
}

class _OrderAcceptedState extends State<OrderAccepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 55),
              //  image
              Image.asset('images/acceptimage.png'),
              SizedBox(height: 25),
              //  text header
              myText(title: "Your Order Has Been Accepted", textColor: appColors.textBrown,fontSize: 20,fontWeight: FontWeight.w700,),
              SizedBox(height: 16),
              // main text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: myText(title: "We’ve accepted your order, and we’re getting it ready.",
                    textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.center),
              ),
              SizedBox(height: 30),
              //  track order button
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: appColors.appOrange
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                      onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage(),));
                      },
                      child: Center(child: myText(title: "Track Order", textColor: appColors.backgroundWhite,fontSize: 17, fontWeight: FontWeight.w700,))),
                ),
              ),

              SizedBox(height: 16),
              //  Back Home button
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: appColors.backgroundWhite,
                  border: Border.all(color: appColors.appOrange),
                ),
                child: Center(child: MaterialButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 0),));
                    },
                    child: myText(title: "Back Home", textColor: appColors.appOrange,fontSize: 17, fontWeight: FontWeight.w700,))),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
