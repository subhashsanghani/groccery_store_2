import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http ;

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();
  RoundedLoadingButtonController _CPcontroller =
  new RoundedLoadingButtonController();

  TextEditingController Oldpass = new TextEditingController();
  TextEditingController Newpass = new TextEditingController();
  TextEditingController Conpass = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 85,
          systemOverlayStyle: SystemUiOverlayStyle(
            // statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,

          leadingWidth: 40,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 00),

              child: Icon(Icons.arrow_back_ios,
                  color: appColors.appOrange, size: 18),

            ),
          ),
          title: myText(title: "Change Password",
            textColor: appColors.appOrange,
            fontSize: 22,
            fontWeight: FontWeight.w700,),
          centerTitle: true,


        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // SizedBox(height: 55),
                // main app bar
                //  Row(
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
                //       padding: const EdgeInsets.only(left: 30.0),
                //       child: myText(title: "Change Password", textColor: appColors.appOrange,fontSize: 22,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),
                SizedBox(height: 50),
                // enter pass
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: Oldpass,
                          showCursor: true,
                          cursorColor: appColors.appOrange,
                          validator: (value) {
                            if (value == null || value.length < 6 ||
                                value.isEmpty) {
                              return 'Minimum 6 digits required';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: " Current Password",
                              hintStyle: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 1),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 40),
                // enter pass
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
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
                            if (value == null || value.length < 6 ||
                                value.isEmpty) {
                              return 'Minimum 6 digits required';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: "New Password",
                              hintStyle: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 1),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
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
                            if (value == null || value.length < 6 ||
                                value.isEmpty) {
                              return 'Minimum 6 digits required';
                            } else if (Newpass.text != Conpass.text) {
                              return 'Password does not match';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 1),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: 50),
                //  Confirm
                RoundedLoadingButton(
                    controller: _CPcontroller,
                    errorColor: appColors.appOrange,
                    color: appColors.appOrange,
                    animateOnTap: false,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _CPcontroller.start();
                        ChangePasswordApi(currentPass: Oldpass.text,
                            pass: Newpass.text,
                            newPass: Newpass.text);
                      } else {}
                    },
                    child: Center(child: myText(title: "Confirm",
                      textColor: appColors.backgroundWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,))),


                SizedBox(height: 16),
                //  Back TO sign im
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: appColors.backgroundWhite,
                      border: Border.all(color: appColors.appOrange),
                    ),
                    child: Center(child: myText(title: "Back To Profile",
                      textColor: appColors.appOrange,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  ChangePasswordApi(
      {required String currentPass, required String pass, required String newPass }) async {
    _CPcontroller.start();
    setState(() {});

    var Cpres = await http.post(
        Uri.https(apiIp.ipAddress, "/glossary/api/changepassword"),
        body: {
          "user_id": await ValueStore().secureReadData("currentUser"),
          "current_password": currentPass,
          "password": pass,
          "confirm_password": newPass,
        });

    var Cpjson = jsonDecode(Cpres.body);

    if (Cpjson["success"]) {
      setState(() {
        Navigator.pop(context);
        MotionToast(
          position: MOTION_TOAST_POSITION.BOTTOM,
          animationType: ANIMATION.FROM_LEFT,
          animationCurve: Curves.linear,
          icon: Icons.done,
          width: 310,
          height: 60,
          description: Cpjson['message'],
          title: "",
          titleStyle: TextStyle(fontSize: 16),
          animationDuration: Duration(microseconds: 500),
          descriptionStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          toastDuration: Duration(seconds: 4),
          color: Colors.green.shade500,
        ).show(context);
      }


      );


      _CPcontroller.stop();

      setState(() {});
    }
  }
}