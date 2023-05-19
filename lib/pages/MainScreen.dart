import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:groccery_store_2_2/pages/SignUp1.dart';

import 'HomePage.dart';


class MainScreen extends StatefulWidget {
  String refScreen;

   MainScreen({Key? key, required this.refScreen, }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
            //  image
              Image.asset('images/main_img.png' , height: MediaQuery.of(context).size.height / 2.5,),
              SizedBox(height: 35),
            //  text header
              myText(title: "Realax and shop", textColor: appColors.textBrown,fontSize: 20,fontWeight: FontWeight.w700,),
              SizedBox(height: 16),
              // main text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: myText(title: "Shop online and get groceries delivered from stores to your home in as fast as 1 hour .",
                  textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.center),
              ),
              SizedBox(height: 50),
            //  sign up button
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp1(),));
                    },
                      child: Center(child: myText(title: "Sign up", textColor: appColors.backgroundWhite,fontSize: 17, fontWeight: FontWeight.w700,))),
                ),
              ),

              SizedBox(height: 16),
            //  sign in button
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: appColors.backgroundWhite,
                  border: Border.all(color: appColors.appOrange),
                ),
                child: MaterialButton(
                    onPressed:(){
                      Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => SignIn(refScreen:widget.refScreen)));
                    },
                    child: Center(child: myText(title: "Sign in", textColor: appColors.appOrange,fontSize: 17, fontWeight: FontWeight.w700,))),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
