import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/AddressesPage.dart';
import 'package:groccery_store_2_2/pages/SocietyPage.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;


class NewAddressesPage extends StatefulWidget {
  const NewAddressesPage({Key? key}) : super(key: key);

  @override
  State<NewAddressesPage> createState() => _NewAddressesPageState();
}

class _NewAddressesPageState extends State<NewAddressesPage> {

  RoundedLoadingButtonController _AddController = RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController RecName = TextEditingController();
  TextEditingController Recphone = TextEditingController();
  TextEditingController Recpincode = TextEditingController();
  TextEditingController RecAdd = TextEditingController();
  GetStorage _getStorage = GetStorage();

  bool Loaded = true ;
  String Society ="Society";
  var Json;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            margin: EdgeInsets.only(left: 20 , top: 10),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ),

        title:  myText(title: " New Address", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                //       padding: const EdgeInsets.only(left: 40.0),
                //       child: myText(title: "New Addresses", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //     ),
                //   ],
                // ),
                SizedBox(height: 35),
                //  receiver name text field
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
                          controller: RecName,
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
                              hintText: "Receiver Full Name",
                              hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 0.4),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30),
                //  mobile text field
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
                          controller: Recphone,
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
                            errorStyle: TextStyle(height: 0.4),
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
                SizedBox(height: 30),
                //  pincode text field
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
                          controller: Recpincode,
                          showCursor: true,
                          cursorColor: appColors.appOrange,

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 6) {
                              return 'Enter 6 digit pincode';
                            }


                            else {
                              return null;
                            }
                          },
                          obscureText: false,
                          maxLength: 6,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 0.4),
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Pincode",
                            hintStyle: TextStyle(fontSize: 16 , color: appColors.hint , fontWeight: FontWeight.w400),
                            focusedBorder: InputBorder.none,

                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30),
              //  house number text field
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
                          controller: RecAdd,
                          showCursor: true,
                          cursorColor: appColors.appOrange,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'Please Enter A Valid Address';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: "Receiver House Number",
                              hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 0.4),
                              focusedBorder: InputBorder.none),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30),
              // scoiety selection
                Container(
                  decoration: BoxDecoration(
                    color:appColors.borderGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () async{
                     Json =   await   Navigator.push(context, MaterialPageRoute(builder: (context) => SocietyPage(),));
                    print(Json);
                    Society=Json['socName'];
                    setState(() {

                    });
                        },

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25 , vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(title: Society, textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w400,),
                              Icon(Icons.arrow_forward_ios_sharp, size: 18, color: appColors.textBrown2,),
                            ],
                          )
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 50),
                //  add address  button
                RoundedLoadingButton(
                  controller: _AddController,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () async{

                     if(Society!="Society" && _formKey.currentState!.validate()){
                      AddAddressApi( await ValueStore().secureReadData("currentUser"),
                          // _getStorage.read("userId").toString(),
                          Recpincode.text,
                          Json['socId'].toString(),
                          RecAdd.text,
                          RecName.text,
                          Recphone.text
                      );
                      Navigator.push(context , MaterialPageRoute(builder: (context) => AddressesPage(),),);
                      setState(() {

                      });
                    }
                    else if(Society == "Society") {

                      MotionToast(
                        position: MOTION_TOAST_POSITION.BOTTOM,
                        animationType: ANIMATION.FROM_LEFT,
                        animationCurve: Curves.linear,
                        icon: Icons.person,
                        height: 60,
                        borderRadius: 8,
                        width: MediaQuery.of(context).size.width/1.035,
                        description: "Please check credentials",
                        title: "Please select society !",
                        titleStyle: TextStyle(fontSize: 14),
                        animationDuration: Duration(microseconds: 300),
                        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
                        toastDuration: Duration(seconds: 2),
                        color: Colors.deepOrange.shade400,
                      ).show(context);
                      FocusManager.instance.primaryFocus?.unfocus();
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
                          title: "Add",
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          fontSize: 18,
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
  void AddAddressApi(String userId , String pincode , String socity , String house , String rname ,String rmobile) async{

    setState(() {
      _AddController.start();
    });
    Loaded=true;

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/addadress')),

        body: {
          "user_id": await ValueStore().secureReadData("currentUser"),
          "pincode": pincode,
          "socity": socity,
          "House": house,
          "receiver_name": rname,
          "receiver_mobile": rmobile,
          // 'user_id':await ValueStore().secureReadData("currentUser") ,
        });

    var AddAddressJson = await jsonDecode(res.body);

    print(AddAddressJson);
    MotionToast(
      position: MOTION_TOAST_POSITION.BOTTOM,
      animationType: ANIMATION.FROM_LEFT,
      animationCurve: Curves.linear,
      icon: Icons.person,
      height: 60,
      borderRadius: 8,
      width: 310,
      description: "",
      title: AddAddressJson["message"].toString(),
      titleStyle: TextStyle(fontSize: 14),
      animationDuration: Duration(microseconds: 300),
      descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
      toastDuration: Duration(seconds: 2),
      color: Colors.teal.shade400,
    ).show(context);
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      Loaded = false;
      _AddController.stop();
    });
  }

}
