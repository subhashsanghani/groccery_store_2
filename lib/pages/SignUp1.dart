import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/pages/MainScreen.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:groccery_store_2_2/pages/SignUpPass.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({Key? key}) : super(key: key);

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController fullName = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final RoundedLoadingButtonController btnControllerSU1 = RoundedLoadingButtonController();

@override
  void initState() {
    // TODO: implement initState
    fullName.text = 'Devdip';
    phone.text ="9081177275";
    email.text= "devdip1234@gmail.com";
    password.text = '123456';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundWhite,
      appBar:  AppBar(
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
        title:  myText(title: "Sign Up", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key:_formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                //       padding: const EdgeInsets.only(left: 72),
                //       child: myText(title: "Sign Up", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),
              // mob image
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset('images/signup_mob.png', height: 220, width:220, fit: BoxFit.cover,),
                ),
              //  name text field
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
                            controller: fullName,
                            showCursor: true,
                            cursorColor: appColors.appOrange,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty) {
                                return 'Please Enter A Valid Name';
                              } else {
                                return null;
                              }
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 1),
                              focusedBorder: InputBorder.none),
                            ),
                      ),

                    ],
                  ),
                ),
              //  mob text field
                SizedBox(height: 16,),
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
                          keyboardType: TextInputType.number,
                          controller: phone,
                          showCursor: true,
                          cursorColor: appColors.appOrange,

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return 'Enter 10 digit Mobile Number';
                            }


                            else {
                              return null;
                            }
                          },
                          obscureText: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 1),
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(fontSize: 16 , color: appColors.hint , fontWeight: FontWeight.w400),
                            focusedBorder: InputBorder.none,

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 16,),
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
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: email,
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
                          obscureText: true,
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

              //  confirmation text
                SizedBox(height: 10,),
                myText(title: "We need to verify you. We will send you a one time verification code.", textColor: appColors.textBrown, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),
              //  next button
                SizedBox(height: 30,),
                RoundedLoadingButton(
                  controller: btnControllerSU1,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    setState(() {

                    });
                    if (_formKey.currentState!.validate()) {

                      setState(() {
                        btnControllerSU1.start();
                        registerUser(fullName.text, email.text, phone.text, password.text);
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
                // already login text
                SizedBox(height: 15,),
                MaterialButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(refScreen: "initial",),));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myText(title: "Already have an account?", textColor: appColors.textBrown, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),
                      myText(title: " Login", textColor: appColors.appOrange, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),

                    ],
                  ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }

  void registerUser(String name, String email, String number,
      String password) async {
  print(name+email);

    var registerResponse = await http.post(
      Uri.https(apiIp.ipAddress,'/glossary/api/registration'),

      body: {
        'user_fullname': name,
        'user_email': email,
        'user_phone': number,
        'user_password': password,
      },
    );
    var jsonRegistry = jsonDecode(registerResponse.body);
    print(jsonRegistry);
    // print(jsonRegistry['message']);
    if (jsonRegistry['success'] == true) {

      print("User  ValidAdded");

      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(refScreen: "initial"),));


      setState(() {
        btnControllerSU1.stop();
        MotionToast(
          position: MOTION_TOAST_POSITION.BOTTOM,
          animationType: ANIMATION.FROM_LEFT,
          animationCurve: Curves.linear,
          icon: Icons.done,
          width: MediaQuery.of(context).size.width/1.035,
          height: 50,
          borderRadius: 8,
          description: "",
          title:jsonRegistry["message"].toString().length>15 ?jsonRegistry["message"].toString().substring(0,35)+"....":jsonRegistry["message"].toString(),
          titleStyle: TextStyle(fontSize: 14 , overflow: TextOverflow.clip , ),
          animationDuration: Duration(microseconds: 500),
          descriptionStyle: TextStyle(
              fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
          toastDuration: Duration(seconds: 2),
          color: Colors.green.shade500,
        ).show(context);

         // Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
      });



    } else {


      MotionToast(
        borderRadius: 10,
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_BOTTOM,
        animationCurve: Curves.easeInOut,
        icon: Icons.close,
        width: MediaQuery.of(context).size.width/1.035,
        iconSize: 20,
        description: "registration failed",
        title: jsonRegistry['message'],
        height: 60,
        titleStyle: TextStyle(fontSize: 14),
        animationDuration: Duration(microseconds: 500),
        descriptionStyle: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w300, color: Colors.black87),
        toastDuration: Duration(seconds: 2),
        color: Colors.red.shade500,
      ).show(context);
      btnControllerSU1.stop();
      FocusManager.instance.primaryFocus?.unfocus();


    }
  }


}
