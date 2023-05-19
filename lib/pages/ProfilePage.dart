import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/pages/ChangePasswordPage.dart';
import 'package:groccery_store_2_2/pages/EditProfilePage.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:http/http.dart' as http;


import '../Components/valueStore.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool switchButton = false ;
 bool isLoad = false;
  GetStorage storey = GetStorage();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
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
        title:  myText(title: "Profile", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            //       padding: const EdgeInsets.only(left: 82.0),
            //       child: myText(title: "Profile", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30),

            // edit profile button Row
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/Icons/profile.png" , height: 24 , width: 24, color: appColors.textBrown,),
                        SizedBox(width: 16,),
                        myText(title: "Edit Profile", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                      ],
                    ),

                    Align(child: Icon(Icons.arrow_forward_ios_sharp , size: 14,color: appColors.textBrown,))
                  ],
                ),
              ),
            ),
            Divider(height: 15,thickness: 1, color: appColors.brownshadow01,),
            //change password
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/Icons/key.png" , height: 24 , width: 24, color: appColors.textBrown,),
                        SizedBox(width: 16,),
                        myText(title: "Change Password", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                      ],
                    ),

                    Align(child: Icon(Icons.arrow_forward_ios_sharp , size: 14,color: appColors.textBrown,))
                  ],
                ),
              ),
            ),
            Divider(height: 15,thickness: 1, color: appColors.brownshadow01,),
            //  my cards
            // MaterialButton(
            //   padding: EdgeInsets.zero,
            //   onPressed: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyCardPage()));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Row(
            //           children: [
            //             Image.asset("images/Icons/cardBrown.png" , height: 24 , width: 24, color: appColors.textBrown,),
            //             SizedBox(width: 16,),
            //             myText(title: "My Cards", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
            //           ],
            //         ),
            //
            //         Align(child: Icon(Icons.arrow_forward_ios_sharp , size: 14,color: appColors.textBrown,))
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 22,),
            //  App settings Header
            Align(
                alignment: Alignment.centerLeft,
                child: myText(title: "App Settings", textColor: appColors.appOrange,fontSize: 22,fontWeight: FontWeight.w700,)),
            SizedBox(height: 35,),

            //  notifications
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/Icons/bell.png" , height: 24 , width: 24, color: appColors.textBrown,),
                        SizedBox(width: 16,),
                        myText(title: "Notifications", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                      ],
                    ),

                    FlutterSwitch(
                      value: switchButton,
                      onToggle: (val){
                        setState(() {
                          switchButton= val;
                        });
                      } ,
                      height: 25,
                      width: 45,
                      borderRadius: 35  ,
                      activeColor: appColors.appOrange,
                      padding: 1.5,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 15,thickness: 1, color: appColors.brownshadow01,),
            //language
            // MaterialButton(
            //   padding: EdgeInsets.zero,
            //   onPressed: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Row(
            //           children: [
            //             Image.asset("images/Icons/language.png" , height: 24 , width: 24, color: appColors.textBrown,),
            //             SizedBox(width: 16,),
            //             myText(title: "Language", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
            //           ],
            //         ),
            //
            //         Row(
            //           children: [
            //             myText(title: "English", textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,),
            //             SizedBox(width: 15,),
            //             Icon(Icons.arrow_forward_ios_sharp , size: 14,color: appColors.textBrown,),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Divider(height: 15,thickness: 1, color: appColors.brownshadow01,),
            // logout
            MaterialButton(
              padding: EdgeInsets.zero,

                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment:
                          WrapAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets
                                  .symmetric(
                                  horizontal: 25),
                              child: Container(
                                height:
                                MediaQuery.of(context)
                                    .size
                                    .width,
                                width:
                                MediaQuery.of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 2)
                                  ],
                                  borderRadius:
                                  BorderRadius
                                      .circular(25),
                                  color: appColors
                                      .backgroundWhite,
                                  // border: Border.all(color: appColors.textGrey , width: 2)
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    myText(
                                      title: " CONFIRM !",
                                      textColor: appColors
                                          .appOrange,
                                      fontSize: 22,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                          horizontal:
                                          16.0),
                                      child: myText(
                                        title:
                                        "Are you sure you want to logout ?",
                                        textColor:
                                        appColors
                                            .maroon,
                                        fontSize: 18,
                                        maxLines: 2,
                                        textAlign:
                                        TextAlign
                                            .center,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              7,
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              2.8,
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10),
                                            color: appColors
                                                .appOrange,
                                          ),
                                          child: Align(
                                              alignment:
                                              Alignment
                                                  .center,
                                              child: MaterialButton(
                                                  onPressed: () async {
                                                    LogoutApi();

                                                  },
                                                  height: MediaQuery.of(context).size.width / 7,
                                                  minWidth: MediaQuery.of(context).size.width / 2.8,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  animationDuration: Duration(seconds: 2),
                                                  child: myText(
                                                    title:
                                                    "Yes",
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
                                                    textColor:
                                                    appColors.backgroundWhite,
                                                  ))),
                                        ),
                                        Container(
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              7,
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              2.8,
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                10),
                                            color: appColors.appOrange,
                                          ),
                                          child:
                                          MaterialButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(
                                                  context);
                                            },
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                7,
                                            minWidth: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                2.8,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            animationDuration:
                                            Duration(
                                                seconds:
                                                2),
                                            child: Align(
                                                alignment:
                                                Alignment
                                                    .center,
                                                child:
                                                myText(
                                                  title:
                                                  "No",
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                  textColor:
                                                  appColors.backgroundWhite,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]);
                    },
                  );
                  // ValueStore().secureDeleteData("currentUser");
                  // ValueStore().secureDeleteData("isLoggedIn");
                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 0),), (route) => false);
                },
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));

              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset("images/Icons/logout.png" , height: 24 , width: 24, color: appColors.textBrown,),
                        SizedBox(width: 16,),
                        myText(title: "Logout", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                      ],
                    ),

                    Align(child: Icon(Icons.arrow_forward_ios_sharp , size: 14,color: appColors.textBrown,))
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void LogoutApi() async{

    isLoad = true;
    setState(() {

    });
    print(storey.read("FCMtoken").toString() + "TOKEN");

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/logout')),
      body: {
      "user_id": await ValueStore().secureReadData("currentUser"),
      "fcmtoken":   await ValueStore().secureReadData("FCMtoken")
      }
    );

    var logoutJson = await jsonDecode(res.body);

    if(logoutJson['success']==true){
       await ValueStore().secureDeleteData("currentUser");
       await ValueStore().secureDeleteData("isLoggedIn");
      await storey.remove("FCMtoken");

       Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
           builder: (context) => HomePage(tabPos: 0),
         ),(route) => false,);
      setState(
              () {


          });

    }

    print("logoutJson");
    print(logoutJson);

    isLoad = false;
    setState(() {

  });
  }

}
