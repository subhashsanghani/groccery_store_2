import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Components/ColorsFile.dart';
import 'OtpPage.dart';

class SignUpPass extends StatefulWidget {


  @override
  State<SignUpPass> createState() => _SignUpPassState();
}

class _SignUpPassState extends State<SignUpPass> {

  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnControllerSUP= RoundedLoadingButtonController();
  TextEditingController password = new TextEditingController();
  TextEditingController conPassword = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    password.text = "123456";
    conPassword.text = "123456";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 25,),
              // back button
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 40,
                  width: 40,

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {

                        },
                        child: Center(child: Icon(Icons.arrow_back_ios,
                          color: appColors.appOrange, size: 14,))),
                  ),
                ),
              ),
              //  sign up text
              myText(title:'Sign Up',textColor: appColors.appOrange, fontSize: 24, fontWeight: FontWeight.w700,),
              // mob image
              Image.asset('images/signup_mob.png', height: 290, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
            //  pass text
              Align(
                  alignment: Alignment.centerLeft,
                  child: myText(title:'Enter the password',textColor: appColors.textBrown, fontSize: 20, fontWeight: FontWeight.w700,)),
              SizedBox(height: 12,),
            //  info text
              myText(title:'For the security & safety please choose a password' ,textColor: appColors.textBrown, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),

               SizedBox(height: 16,),
              // enter pass
              Container(
                decoration: BoxDecoration(
                  color:appColors.borderGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: password,
                        showCursor: true,
                        cursorColor: appColors.appOrange,
                        validator: (value) {
                          if (value == null ||value.length<6 ||
                              value.isEmpty) {
                            return 'Minimum 6 digits required';
                          } else {
                            return null;
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                            border: InputBorder.none,
                            errorStyle: TextStyle(height: 1),
                            focusedBorder: InputBorder.none),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 16),
              //confirm pass
              Container(
                decoration: BoxDecoration(
                  color:appColors.borderGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: conPassword,
                        showCursor: true,
                        cursorColor: appColors.appOrange,
                        validator: (value) {
                          if (value == null ||value.length<6 ||
                              value.isEmpty) {
                            return 'Minimum 6 digits required';
                          } else {
                            return null;
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                            border: InputBorder.none,
                            errorStyle: TextStyle(height: 1),
                            focusedBorder: InputBorder.none),
                      ),
                    ),

                  ],
                ),
              ),
              //  next button
              SizedBox(height: 16),
              RoundedLoadingButton(
                controller: btnControllerSUP,
                errorColor: appColors.appOrange,
                color: appColors.appOrange,
                animateOnTap: false,
                onPressed: () {
                  setState(() {

                  });
                  if (_formKey.currentState!.validate()) {
                    btnControllerSUP.start();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),));
                    btnControllerSUP.stop();
                  } else {

                  }
                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width / 6.25,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: appColors.appOrange,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Align(
                      alignment: Alignment.center,
                      child: myText(
                        title: "Next",
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
