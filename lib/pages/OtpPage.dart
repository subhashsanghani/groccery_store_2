import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:groccery_store/Components/valueStore.dart';
// import 'package:groccery_store/pages/ChangePasswordPage.dart';
// import 'package:groccery_store/pages/RenewPassword.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Components/ColorsFile.dart';
import 'RenewPassword.dart';
import 'SignIn.dart';
import 'SignUpPass.dart';

class OtpPage extends StatefulWidget {


  @override
  State<OtpPage> createState() => _OtpPageState();
}
 

class _OtpPageState extends State<OtpPage> {

  final _formKey = GlobalKey<FormState>();
  Timer? timer;
  int start = 30;
  var verifyOtpJson;
  GetStorage storeBox = new GetStorage();
  final RoundedLoadingButtonController btnControllerOTP = RoundedLoadingButtonController();
  var oneSec = const Duration(seconds: 1);

  void startTimer() {
    timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (start == 0) {
          timer.cancel();
          setState(() {

          });
        } else {
          start--;
          setState(() {

          });
        }
      },);
    start = 30;
  }

  final TextEditingController fieldOne = TextEditingController();

  final TextEditingController fieldTwo = TextEditingController();

  final TextEditingController fieldThree = TextEditingController();

  final TextEditingController fieldFour = TextEditingController();
  final TextEditingController fieldFive = TextEditingController();
  final TextEditingController fieldSix = TextEditingController();

  @override
  void initState() {
    startTimer();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 85,
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        // leadingWidth: 40,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20 , top: 0),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ),
        title:  myText(title: "Enter OTP", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 55),
                // main app bar
                // Row(
                //   children: [
                //     // back button
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Align(
                //         alignment: Alignment.centerLeft,
                //         child: Container(
                //           height: 40,
                //           width: 40,
                //
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(40),
                //             child: MaterialButton(
                //                 padding: EdgeInsets.zero,
                //                 onPressed: () {
                //
                //                 },
                //                 child: Center(child: Icon(Icons.arrow_back_ios,
                //                   color: appColors.appOrange, size: 18,))),
                //           ),
                //         ),
                //       ),
                //     ),
                //
                //     Padding(
                //       padding: const EdgeInsets.only(left: 58),
                //       child: myText(title: "Enter OTP",
                //         textColor: appColors.appOrange,
                //         fontSize: 24,
                //         fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),
                // mob image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Image.asset(
                    'images/codeDone.png', height: 210, width: 240,)),
                ),
                //  pass text
                SizedBox(height: 30),
                Align(
                    alignment: Alignment.centerLeft,
                    child: myText(title: 'Enter Verification Code',
                      textColor: appColors.maroon,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,)),
                SizedBox(height: 12,),
                //  info text
                myText(title: 'We have sent Email To :',
                  textColor: appColors.textBrown,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                  textAlign: TextAlign.start,),
                myText(title: storeBox.read('emailInput'),
                  textColor: appColors.appOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                  textAlign: TextAlign.start,),
                SizedBox(height: 20,),
                // otp fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    setOtp(fieldOne, false),
                    setOtp(fieldTwo, false),
                    setOtp(fieldThree, false),
                    setOtp(fieldFour, false),
                    setOtp(fieldFive, false),
                    setOtp(fieldSix, false),
                  ],
                ),
                SizedBox(height: 20,),
                // timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myText(title: " have’nt received otp ? ",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      textColor: appColors.textBrown2,),
                    GestureDetector(
                        onTap: () {
                          if (start != 0) {

                          } else {
                            start = 10;
                             forgotApi(storeBox.read("emailInput"));
                            MotionToast(
                              position: MOTION_TOAST_POSITION.BOTTOM,
                              animationType: ANIMATION.FROM_LEFT,
                              animationCurve: Curves.linear,
                              icon: Icons.done,
                              width: 310,
                              description: "please check your Email",
                              title: "",
                              titleStyle: TextStyle(fontSize: 14),
                              animationDuration: Duration(microseconds: 500),
                              descriptionStyle: TextStyle(fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              toastDuration: Duration(seconds: 3),
                              color: Colors.green.shade500,
                            ).show(context);
                            startTimer();
                          }
                        },
                        child: myText(
                          title: "${start == 0 ? "" : start} Resend",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          textColor: start == 0 ? appColors.maroon : appColors
                              .medMaroon,)),
                  ],
                ),
                SizedBox(height: 10,),
                //  validate button
                SizedBox(height: 16),
                RoundedLoadingButton(
                  controller: btnControllerOTP,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    if(fieldOne.text.isNotEmpty && fieldTwo.text.isNotEmpty && fieldThree.text.isNotEmpty && fieldFour.text.isNotEmpty && fieldFive.text.isNotEmpty && fieldSix.text.isNotEmpty)

                      // }
                      verifyOtpApi(storeBox.read("emailInput") , fieldOne.text, fieldTwo.text , fieldThree.text , fieldFour.text , fieldFive.text , fieldSix.text);
                    else{
                      MotionToast(
                        position: MOTION_TOAST_POSITION.BOTTOM,
                        animationType: ANIMATION.FROM_LEFT,
                        animationCurve: Curves.linear,
                        icon: Icons.close,
                        width: 310,
                        description: "please enter correct OTP",
                        title: "Some fields are empty",
                        titleStyle: TextStyle(fontSize: 16),
                        animationDuration: Duration(microseconds: 500),
                        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
                        toastDuration: Duration(seconds: 2),
                        color: Colors.red.shade500,
                      ).show(context);
                    }
                    // startTimer();


                    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
                          title: "Validate",
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
      ),
    );
  }
  void forgotApi(String email) async{

    var resp=await http.post(  Uri.https(apiIp.ipAddress, '/glossary/api/fargotpassword'),
      headers:  {'x-api-key':'99e1bb00b05ec7b10343b92815a2e7f4'  },
      body: {'user_email':email},
    );
     var forgotJson = jsonDecode(resp.body);
    print(forgotJson);
  }

  void verifyOtpApi(String email , String text, String text2, String text3, String text4, String text5, String text6) async{
    String finalOtp = text+text2+text3+text4+text5+text6;
    btnControllerOTP.start();
    var resp=await http.post(  Uri.https(apiIp.ipAddress, '/glossary/api/validateotp'),

      body: {
        'email':email,
        'forget_code': finalOtp

      },
    );
    verifyOtpJson = jsonDecode(resp.body);
    print(verifyOtpJson);

    if(verifyOtpJson['code']== 200){


      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Future.delayed(Duration(seconds: 1),() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RenewPassword()));

        MotionToast(
          position: MOTION_TOAST_POSITION.BOTTOM,
          animationType: ANIMATION.FROM_LEFT,
          animationCurve: Curves.linear,
          icon: Icons.done,
          width: 310,
          height: 60,
          description: "",
          title: verifyOtpJson['message'],
          titleStyle: TextStyle(fontSize: 16),
          animationDuration: Duration(microseconds: 500),
          descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
          toastDuration: Duration(seconds: 1),
          color: Colors.green.shade500,
        ).show(context);
        btnControllerOTP.stop();
      }

      );


    }else {


      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.close,
        width: 310,
        description: "please enter correct OTP",
        title: verifyOtpJson['message'],
        titleStyle: TextStyle(fontSize: 16),
        animationDuration: Duration(microseconds: 500),
        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
        toastDuration: Duration(seconds: 2),
        color: Colors.red.shade500,
      ).show(context);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      btnControllerOTP.stop();

      fieldOne.text="";
      fieldTwo.text="";
      fieldThree.text="";
      fieldFour.text="";
      fieldFive.text="";
      fieldSix.text="";

    }

  }
}

class setOtp extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const setOtp(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.all(5.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: appColors.lightOrange,
            border: Border.all(color: Colors.white,width: 1),
            boxShadow: [
              BoxShadow(
                  color: appColors.backgroundWhite,
                  blurRadius: 2
              )
            ]
          // color: Colors.blue
        ),
        child: TextField(
          autofocus: autoFocus,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: const InputDecoration(
              border:  InputBorder.none,
              counterText: '',
              hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }else{
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }






}
