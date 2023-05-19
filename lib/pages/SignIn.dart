import 'dart:convert';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/MainScreen.dart';
import 'package:groccery_store_2_2/pages/SignUp1.dart';
import 'package:groccery_store_2_2/pages/SignUpPass.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ForgotPassword.dart';


class SignIn extends StatefulWidget {

  String refScreen;

   SignIn({Key? key, required this.refScreen, }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GetStorage _storeBox = new GetStorage();
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final RoundedLoadingButtonController btnControllerSI1 = RoundedLoadingButtonController();
  String? deviceTokenToSendPushNotification;
  GetStorage storey = GetStorage();


  Future<void> getDeviceTokenToSendNotification() async {


    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }


  @override
  void initState() {
    // TODO: implement initState
    email.text = 'devdip1234@gmail.com';
    password.text ="112233";
    getDeviceTokenToSendNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundWhite,
      appBar:   AppBar(
        // toolbarHeight: 85,
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.refScreen!="initial"?InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20 , top: 0),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ):SizedBox.shrink(),
        actions: [
        widget.refScreen=="initial"?  MaterialButton(
            height: 30,
            minWidth: 70,
            // padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
            onPressed: () async{
              await ValueStore().secureWriteData("isSkipped", "true");
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage(tabPos: 0),) ,(route) => false,);
            },
            child: Row(
              children: [
                myText(title: "skip", textColor: appColors.maroon,fontWeight: FontWeight.w600, fontSize: 18,),
                SizedBox(width: 3,),
                Icon(Icons.arrow_forward_ios_sharp , size: 18 , color: appColors.maroon),


              ],
            ),
          ):SizedBox.shrink()
        ],

        // leadingWidth: 40,
        // leading: InkWell(
        //   onTap: (){
        //     Navigator.pop(context);
        //   },
        //   child: Container(
        //     margin: EdgeInsets.only(left: 20 , top: 10),
        //
        //     child: Icon(Icons.arrow_back_ios,
        //         color: appColors.appOrange, size: 18),
        //
        //   ),
        // ),
        title:  myText(title: "Sign In", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
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
                // // main app bar
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
                //       padding: const EdgeInsets.only(left: 75),
                //       child: myText(title: "Sign In", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),

                // mob image
                Image.asset('images/signin.png', height: 200, width: MediaQuery.of(context).size.width,),
                //des text
                myText(title:'Enter your phone number and password to access your account',
                  textColor: appColors.textBrown, fontSize: 18, fontWeight: FontWeight.w400, textAlign: TextAlign.start,maxLines: 3,),
                SizedBox(height: 20,),
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
                //  pass text field
                SizedBox(height: 30,),
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
                        padding: const EdgeInsets.only(left: 25),
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
                //  confirmation text
                SizedBox(height: 10,),

                //Forgot password
                Align(
                  alignment: Alignment.centerRight,
                    child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                        },
                        child: myText(title: "Forgot Password", textColor: appColors.appOrange, fontSize: 14, fontWeight: FontWeight.w400, maxLines: 3,))),
                //  next button
                SizedBox(height: 30,),
                RoundedLoadingButton(
                  controller: btnControllerSI1,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    setState(() {

                    });
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        btnControllerSI1.start();
                        loginByValues(email.text, password.text);
                      });


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
                          title: "Sign In",
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),

                  ),
                ),
                // already login text
                SizedBox(height: 20,),
                MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp1(),));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myText(title: "Don't have an account?", textColor: appColors.textBrown, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),
                      myText(title: " Sign Up", textColor: appColors.appOrange, fontSize: 16, fontWeight: FontWeight.w400, maxLines: 3,),

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

  loginByValues(String loginIdVal, String loginPassVal) async {

    var resp = await http.post(
      Uri.https(apiIp.ipAddress, '/glossary/api/login'),

      body: {
        'email': loginIdVal, 'password': loginPassVal,
      },
    );
   var loginJson =jsonDecode(resp.body);
    print(loginJson['message']);

    if (loginJson['success'] == true) {
      print(loginJson['data']['user']['user_id']);
       _storeBox.write("userId",loginJson['data']["user_id"]);
      // storeBox.write("isLogin", true);

       ValueStore().secureWriteData("isLoggedIn", "yes");
       ValueStore().secureWriteData("currentUser", loginJson['data']['user']['user_id'].toString());
       FcmStoreApi();




      btnControllerSI1.stop();

    }else{


      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.person,
        height: 60,
        borderRadius: 8,
        width: MediaQuery.of(context).size.width/1.035,
        description: "Please check credentials",
        title: loginJson["message"].toString().length>32?loginJson["message"].toString().substring(0,32):loginJson["message"].toString(),
        titleStyle: TextStyle(fontSize: 14),
        animationDuration: Duration(microseconds: 300),
        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
        toastDuration: Duration(seconds: 2),
        color: Colors.red.shade500,
      ).show(context);
      FocusManager.instance.primaryFocus?.unfocus();
      btnControllerSI1.stop();

    }

  }

  void refAction() {
    if(widget.refScreen=="initial"){
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(tabPos: 0)),(route) => false,);
    }
    else if(widget.refScreen=="acc") {Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(tabPos: 4)),(route) => false,);
    }
    else if(widget.refScreen=="cart") {Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(tabPos: 2)),(route) => false,);
    } else if(widget.refScreen=="fav") {Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(tabPos: 3)),(route) => false,);
    } else if(widget.refScreen=="proDetails") {Navigator.pop(context);}
  }

  void FcmStoreApi() async{



    setState(() {

    });
    print(deviceTokenToSendPushNotification.toString()+"TOKEN");
    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/registerfcm' )),
        body: {
          "user_id": await ValueStore().secureReadData("currentUser"),
          "device":"android",
          "token":deviceTokenToSendPushNotification!=null ?deviceTokenToSendPushNotification:"",
        }
    );

    var fcmJson = await jsonDecode(res.body);
    if(fcmJson["success"]){

      refAction();
    }

    print(fcmJson);

    // isLoad = false;
    setState(() {


    });
  }

}
