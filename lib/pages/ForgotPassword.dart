import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import '../Components/ColorsFile.dart';
import '../Components/valueStore.dart';
import 'OtpPage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GetStorage storeBox = new GetStorage();
  RoundedLoadingButtonController Fpass = RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState

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
            margin: EdgeInsets.only(left: 20 , top: 10),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ),
        title:  myText(title: "Forgot Password", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
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
                //       padding: const EdgeInsets.only(left: 25),
                //       child: myText(title: "Forgot Password", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),

                //  image
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(child: Image.asset('images/signup_mob.png', height: 210,width: 250,)),
                ),

                //  text header
                MaterialButton(
                  padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(),));
                    },
                    child: myText(title: "Enter Registered Email Address", textColor: appColors.textBrown,fontSize: 20,fontWeight: FontWeight.w700,)),
                SizedBox(height: 16),
                // main text
                myText(title: "We will sent a otp notification to your registered mail address.",
                    textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.start),
                SizedBox(height: 30),

                // enter email
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: emailCon,
                          showCursor: true,
                          cursorColor: appColors.appOrange,
                          validator: (value) {
                            String pattern =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                r"{0,253}[a-zA-Z0-9])?)*$";
                            RegExp regex = RegExp(pattern);
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return 'Enter A valid Email Address';
                            } else {
                              return null;
                            }
                          },


                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder:InputBorder.none,
                            hintText: "Email Address",
                            hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                //  next button
                SizedBox(height: 50),
                RoundedLoadingButton(
                  controller: Fpass,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    setState(() {
                    });
                    if (_formKey.currentState!.validate()) {

                      setState(() {
                        Fpass.start();
                        forgotApi(emailCon.text);

                      });
                      FocusManager.instance.primaryFocus?.unfocus();
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
      ),
    );
  }

  void forgotApi(String email) async{

    var resp=await http.post(  Uri.https(apiIp.ipAddress, '/glossary/api/fargotpassword'),

      body: {'user_email':email},
    );
   var forgotJson = jsonDecode(resp.body);
    print(forgotJson);

    if(forgotJson['success'] ==true){
      storeBox.write("emailInput", emailCon.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
      Fpass.stop();

    }
    else{

      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.close,
        width:  MediaQuery.of(context).size.width/1.035,
        description: "",
        title: forgotJson['message'],
        titleStyle: TextStyle(fontSize: 14),
        animationDuration: Duration(microseconds: 500),
        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
        toastDuration: Duration(seconds: 3),
        color: Colors.red.shade500,
      ).show(context);
      Fpass.stop();
    }



  }
}
