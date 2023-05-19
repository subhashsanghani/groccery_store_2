import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Models/AddressModel.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/AddressesPage.dart';
import 'package:groccery_store_2_2/pages/BranchDetailsScreen.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/OrderAcceptedPage.dart';
import 'package:groccery_store_2_2/payment/Payment.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import '../Components/ColorsFile.dart';


class PaymentDelivery extends StatefulWidget {
  bool? order_type_pickup;
  String total;
   PaymentDelivery({Key? key,  this.order_type_pickup, required this.total}) : super(key: key);

  @override
  State<PaymentDelivery> createState() => _PaymentDeliveryState();
}

class _PaymentDeliveryState extends State<PaymentDelivery> {
  int selectedIndex = 0 ;
  Userlocation? userLocation;
  GetStorage _paystore = GetStorage();
  bool Loaded = false;
  RoundedLoadingButtonController paycontroller= RoundedLoadingButtonController();
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
        title:  myText(title: "Payment", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: SingleChildScrollView(
        child: Padding(
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
              //       padding: const EdgeInsets.only(left: 70.0),
              //       child: myText(title: "Payment", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
              //     ),
              //   ],
              // ),
            //  Delivery location box
              SizedBox(height: 15),
             widget.order_type_pickup!=null&&widget.order_type_pickup==true? Container(
               decoration: BoxDecoration(
                 color: appColors.lightOrange,
                 borderRadius: BorderRadius.circular(20),

               ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                    //  location and change option row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myText(title:"Branch Location", fontSize:18, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                          MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async{
                               userLocation = await Navigator.push(context, MaterialPageRoute(builder: (context) => BranchDetailsScreen(canpop:true),));


                               setState(() {

                               });

                              },
                              child: myText(title:"Change", fontSize:18, fontWeight: FontWeight.w400, textColor: appColors.appOrange,)),
                        ],
                      ),
                    SizedBox(height: 15,),
                    //  location icon and brief location text row
                      Row(
                        children: [
                         Image.asset("images/Icons/location.png" , height: 30,width: 20,),
                          SizedBox(width: 15,),
                          SizedBox(
                            width: 175,
                              child: myText(
                                 title:
                                _paystore.read("branchName") + " , " + _paystore.read("bra_add") + " , " +  _paystore.read("zipcode").toString() ,

                                fontSize:14, fontWeight: FontWeight.w400, textColor: appColors.textBrown2,maxLines: 3,)),
                        ],
                      )
                    ],
                  ),
                ),
              ):Container(
               decoration: BoxDecoration(
                 color: appColors.lightOrange,
                 borderRadius: BorderRadius.circular(20),

               ),
               child: Padding(
                 padding: const EdgeInsets.all(16),
                 child: Column(
                   children: [
                     //  location and change option row
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         myText(title:"Delivery Location", fontSize:18, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                         MaterialButton(
                             padding: EdgeInsets.zero,
                             onPressed: () async{
                               userLocation = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddressesPage(refScreen: "selectAddress",),));

                               print(userLocation!.socity);
                               print(userLocation!.pincode);
                               print(userLocation!.houseNo);
                               print(userLocation!.pincode);
                               print(userLocation!.pincode);
                               print(userLocation!.pincode);
                               setState(() {

                               });

                             },
                             child: myText(title:userLocation==null?"Select":"Change", fontSize:18, fontWeight: FontWeight.w400, textColor: appColors.appOrange,)),
                       ],
                     ),
                     SizedBox(height: 15,),
                     //  location icon and brief location text row
                     Row(
                       children: [
                         Image.asset("images/Icons/location.png" , height: 30,width: 20,),
                         SizedBox(width: 15,),
                         SizedBox(
                             width: 175,
                             child: myText(
                               title:userLocation==null?
                               "Select Address":
                               userLocation!.houseNo.toString()+" , "+userLocation!.socity![0].socityName.toString()+" , "+ userLocation!.pincode.toString(),
                               fontSize:14, fontWeight: FontWeight.w400, textColor: appColors.textBrown2,maxLines: 3,)),
                       ],
                     )
                   ],
                 ),
               ),
             ),
              SizedBox(height: 25,),
              //  see itmes box
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: appColors.lightOrange,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 2),), (route) => true);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           Image.asset("images/Icons/seeItems.png", height: 25, width: 35,),
                            SizedBox(width: 10,),
                            myText(title:"See Items", fontSize:18, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                          ],
                        ),

                        Icon(Icons.arrow_forward_ios_sharp , color: appColors.textBrown2, size: 20,),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            //  payment methods box
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: appColors.lightOrange,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myText(title:"Payment Method", fontSize:18, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                      SizedBox(height: 10,),
                      Divider(color: appColors.brownshadow01,height: 10, thickness: 1,),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){

                          setState(() {
                            selectedIndex=0;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // card image , type and right button row
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 25),
                              child: Row(
                                children: [
                                  Image.asset("images/Icons/mastercard.png", height: 25, width: 40,),
                                  SizedBox(width: 10,),
                                  myText(title:"Online", fontSize:16, fontWeight: FontWeight.w400, textColor: appColors.textBrown2,),
                                ],
                              ),
                            ),
                          selectedIndex==0?  Icon(Icons.done , color: appColors.bgreen, size: 25,): Icon(Icons.done , color: appColors.lightOrange, size: 25,),

                          ],
                        ),
                      ),
                      Divider(color: appColors.brownshadow01,height: 10, thickness: 1,),
                      MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){

                          setState(() {
                            selectedIndex = 1;
                          });
                          print("$selectedIndex + OOOOOOOOOOOOOOOOOOOOOOOOO");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // card image , type and right button row
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 20),
                              child: Row(
                                children: [
                                  Image.asset("images/Icons/moneyGreen.png", height: 35, width: 40,),
                                  SizedBox(width: 10,),
                                  myText(title:"Cash On Delivery", fontSize:16, fontWeight: FontWeight.w400, textColor: appColors.textBrown2,),
                                ],
                              ),
                            ),
                           selectedIndex==1? Icon(Icons.done , color: appColors.bgreen, size: 25,):  Icon(Icons.done , color: appColors.lightOrange, size: 25,),

                          ],
                        ),
                      ),
                      Divider(color: appColors.brownshadow01,height: 10, thickness: 1,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              //  order summary box
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: appColors.lightOrange,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myText(title:"Order Summary", fontSize:18, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                      SizedBox(height: 5,),
                      Divider(color: appColors.brownshadow01,height: 10, thickness: 1,),
                      // price breakup row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myText(title:"Sub Total", fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 10,),
                              myText(title:"Tax", fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 10,),
                              myText(title:
                              widget.order_type_pickup==true?
                              "Pick Up Charges":"Delivery Charges", fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 5,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              myText(title:widget.total.toString(), fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 10,),
                              myText(title:"0.0", fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 10,),
                              myText(title:
                              widget.order_type_pickup==true?
                              "0.0":
                              userLocation!=null?
                              userLocation!.socity![0].deliveryCharge.toString():"0.0",
                                fontSize:14, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ],
                      ),

                      Divider(color: appColors.brownshadow01,height: 10, thickness: 1,),
                      //total row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myText(title:"Total :", fontSize:16, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                          myText(title:FinalTotal().toString(), fontSize:16, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              RoundedLoadingButton(
                controller: paycontroller,
                errorColor: appColors.appOrange,
                color: appColors.appOrange,
                animateOnTap: false,
                onPressed: () {
                  SendOrderApi();
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
                        title: "Place Order",
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }

  // ################################
  // here selected index are flag for payment type
  // cod or online


  void SendOrderApi() async{
    paycontroller.start();
    Loaded=true;
    setState(() {

    });
    // final queryParameters = {
    //   "user_id" : ValueStore().secureReadData("currentUser");,
    //   "location":  widget.order_type_pickup==true? _paystore.read("branch_id"):userLocation!=null?userLocation!.locationId.toString() :'',
    //   "order_type" : widget.order_type_pickup==true? "pickup":"delivery",
    //   "paid_by" : selectedIndex==1?"cod":"online"
    // };

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/sendorder')),body: {
      "user_id" : await ValueStore().secureReadData("currentUser"),
      "location":  widget.order_type_pickup==true? _paystore.read("branch_id").toString():userLocation!=null?userLocation!.locationId.toString() :'',
      "order_type" : widget.order_type_pickup==true? "pickup":"delivery",
      "paid_by" : selectedIndex==1?"cod":"online"
    });



    var sendOrderJson = await jsonDecode(res.body);

    print(sendOrderJson);

    if(sendOrderJson!=null && sendOrderJson['code']==200 && selectedIndex==1){


      Loaded = false;
      setState(() {

      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAccepted(),));
      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.done,
        height: 60,
        borderRadius: 8,
        width: MediaQuery.of(context).size.width/1.035,
        description: sendOrderJson['message'].toString(),
        title: "",
        titleStyle: TextStyle(fontSize: 14),
        animationDuration: Duration(microseconds: 300),
        descriptionStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
        toastDuration: Duration(seconds: 3),
        color: Colors.greenAccent.shade400,
      ).show(context);

      paycontroller.stop();
      setState(() {

      });
    }
    else if (sendOrderJson!=null && sendOrderJson['code']==200 && selectedIndex==0){
      Loaded = false;
      setState(() {

      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(paymentUrl: sendOrderJson['data']['url'].toString(),),));
      paycontroller.stop();
      setState(() {

      });
    }


    else {
      Loaded = false;
      paycontroller.stop();
      setState(() {

      });
      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.info_outline,
        height: 60,
        borderRadius: 8,
        width: MediaQuery.of(context).size.width/1.035,
        description: sendOrderJson!=null?sendOrderJson['message']:'',
        title: "",
        titleStyle: TextStyle(fontSize: 14 , color: Colors.white),
        animationDuration: Duration(microseconds: 300),
        descriptionStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black),
        toastDuration: Duration(seconds: 3),
        color: Colors.redAccent.shade400,
      ).show(context);

    }

  }

  FinalTotal() {

    double x = widget.total != 'null' ?double.parse(widget.total):0.0;
    double y =userLocation!=null? double.parse(userLocation!.socity![0].deliveryCharge.toString()):0.0;

    double z = x+y;
    return z;

  }


}
