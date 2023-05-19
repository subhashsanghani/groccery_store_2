import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import '../Components/ColorsFile.dart';

class RenewPassword extends StatefulWidget {
  const RenewPassword({Key? key}) : super(key: key);

  @override
  State<RenewPassword> createState() => _RenewPasswordState();
}

class _RenewPasswordState extends State<RenewPassword> {

  final _formKey = GlobalKey<FormState>();
  GetStorage storeBox = new GetStorage();
  RoundedLoadingButtonController btnControllerRNP = RoundedLoadingButtonController();
  TextEditingController Newpass = new TextEditingController();
  TextEditingController Conpass = new TextEditingController();

  var renewJson;

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
        title:  myText(title: "Reset Password", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
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
                //       padding: const EdgeInsets.only(left: 35.0),
                //       child: myText(title: "Reset Password", textColor: appColors.appOrange,fontSize: 22,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),


                // mob image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Image.asset(
                    'images/signup_mob.png', height: 200, width: 220,)),
                ),
                //  pass text
                SizedBox(height: 0),
                Align(
                    alignment: Alignment.centerLeft,
                    child: myText(title: 'Enter New Password',
                      textColor: appColors.maroon,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,)),
                SizedBox(height: 12,),
                //  info text
                Align(
                  alignment: Alignment.centerLeft,
                  child: myText(title: 'For the security & safety please choose a password',
                    textColor: appColors.textBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    maxLines: 3,
                    textAlign: TextAlign.start,),
                ),
                SizedBox(height: 20),
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
                          controller: Newpass,
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
                              errorStyle: TextStyle(height: 0.5),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 16),
                //new pass
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
                          controller: Conpass,
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
                              hintText: "Re-Enter Password",
                              hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 0.5),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 50),
                //  Confirm
                RoundedLoadingButton(
                  controller: btnControllerRNP,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if(_formKey.currentState!.validate()){
                      if(Newpass.text==Conpass.text){

                        newPasswprdApi(storeBox.read("emailInput"), Newpass.text.toString(), Conpass.text.toString());
                        Future.delayed(Duration(seconds: 2),() => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignIn(refScreen: "initial",)),(route) => false),);


                      }else{
                        MotionToast(
                          position: MOTION_TOAST_POSITION.BOTTOM,
                          animationType: ANIMATION.FROM_LEFT,
                          animationCurve: Curves.linear,
                          icon: Icons.close,
                          width: 295,
                          iconSize: 25,
                          description: "Please enter same password",
                          title: "Passwords are not same",
                          titleStyle: TextStyle(fontSize: 14),
                          animationDuration: Duration(microseconds: 500),
                          descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
                          toastDuration: Duration(seconds: 3),
                          color: Colors.red.shade500,
                        ).show(context);
                      }

                    }else {
                      MotionToast(
                        position: MOTION_TOAST_POSITION.BOTTOM,
                        animationType: ANIMATION.FROM_LEFT,
                        animationCurve: Curves.linear,
                        icon: Icons.close,
                        width: 295,
                        description: "Please Enter A Valid Password",
                        title: "Password is too short !",
                        titleStyle: TextStyle(fontSize: 16),
                        animationDuration: Duration(microseconds: 500),
                        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
                        toastDuration: Duration(seconds: 2),
                        color: Colors.red.shade500,
                      ).show(context);
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
                          title: "Confirm",
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

  void newPasswprdApi(String email , String newpass , String conpass) async{
    btnControllerRNP.start();
    setState(() {

    });
    var resp=await http.post(  Uri.https(apiIp.ipAddress, '/glossary/api/resetpassword'),

      body: {'user_email': email,
        'password': newpass,
        'conform_password':conpass,
      },
    );
    renewJson = jsonDecode(resp.body);
    print(renewJson);
    btnControllerRNP.stop();
    setState(() {

    });
    MotionToast(
      position: MOTION_TOAST_POSITION.BOTTOM,
      animationType: ANIMATION.FROM_LEFT,
      animationCurve: Curves.linear,
      icon: Icons.done,
      width: 315,
      height: 55,
      iconSize: 25,
      description: "",
      title: renewJson["message"].toString(),
      titleStyle: TextStyle(fontSize: 12),
      animationDuration: Duration(microseconds: 500),
      descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
      toastDuration: Duration(seconds: 1),
      color: Colors.green.shade500,
    ).show(context);








  }

}
