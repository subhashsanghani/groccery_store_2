import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'SocietyPage.dart';

//
// _storeBox.write("userName", AddressData!.data!.userlocation![index].receiverName);
// _storeBox.write("userPhone", AddressData!.data!.userlocation![index].receiverMobile);
// _storeBox.write("userPincode", AddressData!.data!.userlocation![index].pincode);
// _storeBox.write("userHouse", AddressData!.data!.userlocation![index].houseNo);
// _storeBox.write("userSocietyId", AddressData!.data!.userlocation![index].socityId);

class UpdateAddress extends StatefulWidget {
  const   UpdateAddress({Key? key}) : super(key: key);

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  RoundedLoadingButtonController _AddController = RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();
  GetStorage _storeBox = GetStorage();

  TextEditingController RecName = TextEditingController();
  TextEditingController Recphone = TextEditingController();
  TextEditingController Recpincode = TextEditingController();
  TextEditingController RecAdd = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    RecName.text = _storeBox.read("userName");
    Recphone.text =_storeBox.read("userPhone");
    Recpincode.text =_storeBox.read("userPincode");
    RecAdd.text =_storeBox.read("userHouse");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 55),
                // main app bar
                Row(
                  children: [
                    // back button
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
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
                                  color: appColors.appOrange, size: 18,))),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: myText(title: "Edit Addresses", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                    ),
                  ],
                ),
                SizedBox(height: 55),
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SocietyPage(),));
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25 , vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                myText(title: "Society", textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w400,),
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
                  onPressed: () {
                    setState(() {

                    });
                    if (_formKey.currentState!.validate()) {
                      _AddController.start();

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
                          title: "Update Address",
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
}
