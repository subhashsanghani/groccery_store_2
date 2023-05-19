import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:groccery_store_2_2/pages/OrdersPage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Models/OrderDetailsModel.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/CartFragment.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'HomePage.dart';


class OrderDetailsScreen extends StatefulWidget {
  String? sale_id;
  String? created_at;
  String? status;
   OrderDetailsScreen({Key? key,  required this.sale_id, required this.created_at, required this.status }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  bool Loaded = false;
  OrderDetailsModel? ordersDetailsData = OrderDetailsModel();


  @override
  void initState() {
    // TODO: implement initState
    OrderDetailsApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar:   AppBar(
        // toolbarHeight: 85,
        systemOverlayStyle: SystemUiOverlayStyle(
          // statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        leadingWidth: 40,
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
        title:  myText(title: "Order Details", textColor: appColors.appOrange,fontSize: 22,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:Loaded==true?
          Center(child: CircularProgressIndicator(color: appColors.appOrange,))
          :Stack(

        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: appColors.backgroundWhite,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: appColors.shadow , blurRadius: 10)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 16),
                      child: Column(

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                children: [
                                  myText(title:"Order : ", myStyle: TextStyle(fontSize: 14 , color: Colors.black , fontWeight: FontWeight.w500),),
                                  myText(title:"#"+widget.sale_id.toString(), myStyle: TextStyle(fontSize: 14 , color: appColors.maroon, fontWeight: FontWeight.w700),),
                                ],
                              ),
                              Row(

                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  myText(title: "Order Status :  ", myStyle: TextStyle(fontSize: 14 , color: Colors.black, fontWeight: FontWeight.w500),),

                                  myText(title: ordersDetailsData!.data!.orderdetail!.status==0
                                      ? "Pending"
                                      :  ordersDetailsData!.data!.orderdetail!.status==1
                                      ? "Confirmed"
                                      : ordersDetailsData!.data!.orderdetail!.status==2
                                      ? "Delivered"
                                      :  ordersDetailsData!.data!.orderdetail!.status==3
                                      ? "Canceled"
                                      : ordersDetailsData!.data!.orderdetail!.status==4
                                      ? "Out For Delivery"
                                      : "N/A",

                                    myStyle: TextStyle(fontSize: 14 , color: appColors.bgreen ,fontWeight: FontWeight.w700),),



                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              myText(title:"Created At :  ", myStyle: TextStyle(fontSize: 14 , color: Colors.black , fontWeight: FontWeight.w500),),
                              myText(title:widget.created_at, myStyle: TextStyle(fontSize: 14 , color: appColors.maroon , fontWeight: FontWeight.w700),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),



                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: ordersDetailsData!.data!.orderdetail!.saleitems!.length,
                    itemBuilder: (context, index) {
                      return   Column(
                        children: [
                          SizedBox(
                            height: 105,
                            child: Padding(
                              padding:   EdgeInsets.symmetric(horizontal: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // product image
                                  SizedBox(height: 75, width: 75,
                                      child:CachedNetworkImage(
                                        imageUrl:"",
                                        placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                                        errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                                      )
                                  ),

                                  SizedBox(width: 0,),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // name
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width/2.3,
                                          child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: myText(title: ordersDetailsData!.data!.orderdetail!.saleitems![index].productName, textColor: appColors.textBrown2,fontSize: 20,fontWeight: FontWeight.w700,))),
                                      SizedBox(height: 0,),
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width/2.3,
                                          child: myText(title: ordersDetailsData!.data!.orderdetail!.saleitems![index].qtyInKg.toString(), textColor: Colors.black,fontSize: 12,fontWeight: FontWeight.w500,)),
                                      SizedBox(height: 10,),



                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      myText(title: "X"+" "+ordersDetailsData!.data!.orderdetail!.saleitems![index].qty.toString(), textColor: Colors.black,fontSize: 12,fontWeight: FontWeight.w600,),
                                      myText(title: "\$ "+ ordersDetailsData!.data!.orderdetail!.saleitems![index].price.toString(), textColor: appColors.appOrange,fontSize: 22,fontWeight: FontWeight.w700,),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Divider(height: 5 ,thickness: 1,color: appColors.brownshadow01,)
                        ],
                      );

                    },

                  ),
                ],

              ),
            ),
          ),
          //bottom total container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(

              height: 185,
              decoration: BoxDecoration(
                color: appColors.backgroundWhite,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25) , topRight: Radius.circular(25)),
                boxShadow: [BoxShadow(color: Colors.grey.shade300 , offset: Offset(0 ,-10) , blurRadius: 10)],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 12, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.06),
                                offset: Offset(0, 4),
                                blurRadius: 30)
                          ],
                          color: appColors.backgroundWhite),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    myText(
                                        title: "Sub Total",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        fontfamily: "DMSans-Regular"),
                                    myText(
                                        title:
                                        ordersDetailsData!.data!.orderdetail!.totalAmount.toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        fontfamily: "DMSans-Regular"),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    myText(
                                        title: "Coupon Discount",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        fontfamily: "DMSans-Regular"),
                                    myText(
                                        title:
                                        "0",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor:
                                        appColors.appOrange,
                                        fontfamily: "DMSans-Regular"),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    myText(
                                        title: "Delivery Charge",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        fontfamily: "DMSans-Regular"),
                                    myText(
                                        title:
                                        ordersDetailsData!.data!.orderdetail!.deliveryCharge.toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                        fontfamily: "DMSans-Regular"),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                myText(
                                    title: "Total Amount",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black,
                                    fontfamily: "DMSans-Medium"),
                                myText(
                                    title:totalPrice(),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    textColor: appColors.appOrange,
                                    fontfamily: "DMSans-Medium"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // cancel order button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appColors.backgroundWhite,
                              border: Border.all(
                                  color:appColors.appOrange,

                                  width: 1)),
                          height: 40,
                          width:
                          MediaQuery.of(context).size.width /
                              2.6,
                          child: MaterialButton(
                              onPressed: () {


                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder:
                                        (BuildContext context) {
                                      return Wrap(
                                          alignment: WrapAlignment
                                              .center,
                                          runAlignment:
                                          WrapAlignment
                                              .center,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  25),
                                              child: Container(
                                                height:
                                                MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width,
                                                width:
                                                MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        25),
                                                    color: appColors
                                                        .backgroundWhite,
                                                    border: Border.all(
                                                        color: appColors.borderGrey,
                                                        width:
                                                        2)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    //confirm
                                                    myText(
                                                      title: "CONFIRM",
                                                      textColor: appColors.red,
                                                      fontSize: 22,
                                                    ),

                                                    myText(
                                                      title: "Are You Sure To Cancel The Order",
                                                      textColor: appColors.textBrown2,
                                                      fontSize: 18,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                    ),

                                                    //buttons Row
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          height:
                                                          MediaQuery.of(context).size.width /
                                                              7,
                                                          width: MediaQuery.of(context).size.width /
                                                              2.8,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                            color:
                                                            appColors.appOrange,
                                                          ),
                                                          child: Align(
                                                              alignment: Alignment.center,
                                                              child: MaterialButton(
                                                                  onPressed: () {
                                                                    OrderCancelApi();


                                                                        setState(() {});
                                                                      },


                                                                  height: MediaQuery.of(context).size.width / 7,
                                                                  minWidth: MediaQuery.of(context).size.width / 2.8,
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                  highlightColor: appColors.maroon,
                                                                  hoverColor: appColors.maroon,
                                                                  animationDuration: Duration(seconds: 2),
                                                                  child: myText(
                                                                    title: "Yes",
                                                                    fontSize: 22,
                                                                    fontWeight: FontWeight.w500,
                                                                    textColor: appColors.backgroundWhite,
                                                                  ))),
                                                        ),
                                                        Container(
                                                          height:
                                                          MediaQuery.of(context).size.width /
                                                              7,
                                                          width: MediaQuery.of(context).size.width /
                                                              2.8,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(10),
                                                            color:
                                                            appColors.appOrange,
                                                          ),
                                                          child:
                                                          MaterialButton(
                                                            onPressed:
                                                                () {
                                                              Navigator.pop(context);
                                                            },
                                                            height:
                                                            MediaQuery.of(context).size.width / 7,
                                                            minWidth:
                                                            MediaQuery.of(context).size.width / 2.8,
                                                            shape:
                                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                            highlightColor:
                                                            appColors.maroon,
                                                            hoverColor:
                                                            appColors.maroon,
                                                            animationDuration:
                                                            Duration(seconds: 2),
                                                            child: Align(
                                                                alignment: Alignment.center,
                                                                child: myText(
                                                                  title: "Cancel",
                                                                  fontSize: 22,
                                                                  fontWeight: FontWeight.w500,
                                                                  textColor: appColors.backgroundWhite,
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

                              },
                              child: Align(
                                  alignment: Alignment.center,
                                  child: myText(
                                    title:  "Cancel Order",
                                    fontSize:
                                   14,
                                    fontWeight: FontWeight.w700,
                                    textColor:
                                         appColors.maroon,

                                    fontfamily: "DMSans-Medium",
                                  ))),
                        ),

                        // re-order
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: appColors.backgroundWhite,
                              border: Border.all(
                                  color: appColors.appOrange,
                                  width: 1)),
                          height: 40,
                          width:
                          MediaQuery.of(context).size.width / 2.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                ReOrderApi();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: myText(
                                      title: "Re Order",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      textColor: Colors.black,
                                      fontfamily:
                                      "fonts/DMSans-Bold.ttf"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      )


    );
  }

  void OrderDetailsApi() async{
    Loaded=true;
    setState(() {

    });
    final queryParameters = {
      "sale_id" : widget.sale_id,
      "user_id": await ValueStore().secureReadData("currentUser"),


    };

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/orderdetail' , queryParameters )));



    var orderDetailsJson = await jsonDecode(res.body);

    print(orderDetailsJson);

    if(orderDetailsJson['success']= true) {

      ordersDetailsData = OrderDetailsModel.fromJson(orderDetailsJson);
      print(ordersDetailsData);

      Loaded = false;
      setState(() {

      });
    }

  }

  void OrderCancelApi() async{
    Loaded=true;
    setState(() {

    });
    final queryParameters = {
      "sale_id" : widget.sale_id,
      "user_id": await ValueStore().secureReadData("currentUser"),


    };

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/cancelorder' , queryParameters )));



    var orderCanelJson = await jsonDecode(res.body);

    print(orderCanelJson);

    if(orderCanelJson['success']= true) {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrdersPage(),));

      MotionToast(
        position: MOTION_TOAST_POSITION.BOTTOM,
        animationType: ANIMATION.FROM_LEFT,
        animationCurve: Curves.linear,
        icon: Icons.done,
        width:  MediaQuery.of(context).size.width/1.035,
        description: "",
        title: orderCanelJson['message'],
        titleStyle: TextStyle(fontSize: 14),
        animationDuration: Duration(microseconds: 500),
        descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
        toastDuration: Duration(seconds: 3),
        color: Colors.orange.shade500,
      ).show(context);



      Loaded = false;
      setState(() {

      });
    }

  }


  void ReOrderApi() async{
    Loaded=true;
    setState(() {

    });
    final queryParameters = {
      "sale_id" : widget.sale_id,
      "user_id":ValueStore().secureReadData("currentUser"),


    };

    var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/reorder' , queryParameters )));



    var reorderJson = await jsonDecode(res.body);

    print(reorderJson);

    if(reorderJson['success']= true) {

     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 1,),), (route) => false);

      Loaded = false;
      setState(() {

      });
    }

  }

  totalPrice() {
    double x = double.parse(ordersDetailsData!.data!.orderdetail!.totalAmount.toString());
    double y = double.parse(ordersDetailsData!.data!.orderdetail!.deliveryCharge.toString());
    double z = x+y;
    return z.toString();

  }
}
