import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:groccery_store_2_2/Models/OrderDetailsModel.dart';
import 'package:groccery_store_2_2/Models/OrderListModel.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/OrderDetailsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../Components/ColorsFile.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {

  late TabController tabController;

  var CurrentDate = DateTime.now();

  bool Loaded = false;

  bool _visible = true;

  OrderListModel orderlistdata = OrderListModel();

  OrderDetailsModel? ordersDetailsData = OrderDetailsModel();

  int? OrderStatus = 0;

  @override
  void initState() {
    OrderListApi();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: appColors.backgroundWhite,
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: myText(title: "Orders",
            textColor: appColors.appOrange,
            fontSize: 24,
            fontWeight: FontWeight.w700,),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(child: Icon(
                Icons.arrow_back_ios_sharp, color: appColors.appOrange,
                size: 20,))),
        ),
        // toolbarHeight: 0,
        // bottom: PreferredSizeWidget,
        bottom: PreferredSize(
          preferredSize: Size(
              100, 80
          ), child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: appColors.borderGrey, width: 1))
          ),
          child: TabBar(
            isScrollable: false,
            indicatorWeight: 3,
            // padding: EdgeInsets.symmetric(horizontal: 16),
            // labelPadding: EdgeInsets.symmetric(horizontal: 16),
            controller: tabController,
            labelColor: appColors.appOrange,
            unselectedLabelColor: appColors.textBrown,
            indicatorColor: appColors.appOrange,
            labelStyle: TextStyle(color: appColors.textBrown2,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: "Ongoing",),

              Tab(text: "History",),


            ],
          ),
        ),
        ),
      ),

      body: Loaded == true ?
      Center(child: CircularProgressIndicator(color: appColors.appOrange,))
          : TabBarView(
        controller: tabController,
        children: [

          ongoingOrderView(),
          historyView()

        ],
      ),

      // Column(
      //   children: [
      //     SizedBox(height: 55),
      //     // main app bar
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16),
      //       child: Row(
      //         children: [
      //           // back button
      //           Padding(
      //             padding: const EdgeInsets.only(left: 8.0),
      //             child: Align(
      //               alignment: Alignment.centerLeft,
      //               child: Container(
      //                 height: 40,
      //                 width: 40,
      //
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(40),
      //                   child: MaterialButton(
      //                       padding: EdgeInsets.zero,
      //                       onPressed: () {
      //
      //                       },
      //                       child: Center(child: Icon(Icons.arrow_back_ios,
      //                         color: appColors.appOrange, size: 18,))),
      //                 ),
      //               ),
      //             ),
      //           ),
      //
      //           Padding(
      //             padding: const EdgeInsets.only(left: 82.0),
      //             child: myText(title: "Orders", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
      //           ),
      //         ],
      //       ),
      //     ),
      //     SizedBox(height: 50),
      //     //  tab bar of categories
      //     Container(
      //       decoration: BoxDecoration(
      //           border: Border(bottom: BorderSide(color: appColors.borderGrey, width: 1))
      //       ),
      //       child: TabBar(
      //         isScrollable: false,
      //
      //         indicatorWeight: 3,
      //         // padding: EdgeInsets.symmetric(horizontal: 16),
      //         // labelPadding: EdgeInsets.symmetric(horizontal: 16),
      //         controller: tabController,
      //         labelColor: appColors.textBrown2,
      //         indicatorColor: appColors.appOrange,
      //         labelStyle: TextStyle(color: appColors.textBrown2 , fontSize: 16 , fontWeight: FontWeight.w400),
      //         indicatorSize: TabBarIndicatorSize.label,
      //         tabs: [
      //           Tab(text: "Ongoing", ),
      //
      //           Tab(text: "History", ),
      //
      //
      //         ],
      //       ),
      //     ),
      //
      //
      //     tabController.index==0?Container(color: Colors.red,):Container(color: Colors.green,),
      //
      //     SizedBox(height: 50),
      //     Column(
      //       children: [
      //         Center(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
      //             child: Image.asset("images/boxPerson.png"),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 32),
      //           child: myText(title: "There is n ongoing order right now. You can order from home", textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 2,),
      //         ),
      //       ],
      //     ),
      //
      //   //
      //
      //   ],
      // ),
    );
  }

  historyView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Cards list
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderlistdata.data!.myoder!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 110,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // card image , name , and number row
                          MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      OrderDetailsScreen(
                                        sale_id: orderlistdata!.data!
                                            .myoder![index].saleId.toString(),
                                        created_at: orderlistdata!.data!
                                            .myoder![index].createdAt
                                            .toString(),
                                        status: orderlistdata!.data!
                                            .myoder![index].status.toString(),
                                      )));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // card image
                                SizedBox(height: 44,
                                    width: 44,
                                    child: Image.asset(
                                      "images/Icons/order.png",)),

                                SizedBox(width: 10,),
                                // card name and number
                                SizedBox(
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      // name
                                      myText(title: "Order" + " #" +
                                          orderlistdata!.data!.myoder![index]
                                              .saleId.toString(),
                                        textColor: appColors.textBrown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,),
                                      SizedBox(height: 7,),
                                      myText(title:orderlistdata!.data!
                                          .myoder![index].status==0
                                          ? "Pending"
                                          : orderlistdata!.data!
                                          .myoder![index].status==1
                                          ? "Confirmed"
                                          :orderlistdata!.data!
                                          .myoder![index].status==2
                                          ? "Delivered"
                                          : orderlistdata!.data!
                                          .myoder![index].status==3
                                          ? "Canceled"
                                          :orderlistdata!.data!
                                          .myoder![index].status==4
                                          ? "Out For Delivery"
                                          : "N/A",
                                        textColor: appColors.bgreen,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,),
                                      SizedBox(height: 7,),
                                      myText(title: orderlistdata!.data!
                                          .myoder![index].createdAt.toString(),
                                        textColor: appColors.textBrown2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //price
                          myText(title: "\$ " +
                              orderlistdata!.data!.myoder![index].totalAmount
                                  .toString(),
                            textColor: appColors.appOrange,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,),


                        ],
                      ),
                    ),
                    Divider(
                      height: 5, thickness: 1, color: appColors.brownshadow01,)
                  ],
                );
              },

            ),
          ],
        ),
      ),
    );
  }

  ongoingOrderView() {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: orderlistdata.data!.ongoing != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30,),
              // order , status , created at row
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: appColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: appColors.shadow, blurRadius: 15)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Column(

                    children: [
                      // order , status row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              myText(title: "Order : ",
                                myStyle: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              myText(title: "#" +
                                  orderlistdata.data!.ongoing!.saleId
                                      .toString(),
                                myStyle: TextStyle(fontSize: 14,
                                    color: appColors.maroon,
                                    fontWeight: FontWeight.w700),),
                            ],
                          ),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              myText(title: "Order Status :  ",
                                myStyle: TextStyle(
                                    fontSize: 14, color: Colors.black , fontWeight: FontWeight.w500),),

                              myText(title: OrderStatus == 0
                                  ? "Pending"
                                  : OrderStatus == 1
                                  ? "Confirmed"
                                  : OrderStatus == 2
                                  ? "Delivered"
                                  : OrderStatus == 3
                                  ? "Canceled"
                                  : OrderStatus == 4
                                  ? "Out For Delivery"
                                  : "N/A",
                                myStyle: TextStyle(fontSize: 14,
                                    color: appColors.bgreen,
                                    fontWeight: FontWeight.w700),),


                            ],
                          ),
                        ],
                      ),
                      // created At
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          myText(title: "Order Time :  ", myStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),),
                          myText(title: orderlistdata.data!.ongoing!.createdAt
                              .toString(), myStyle: TextStyle(fontSize: 14,
                              color: appColors.maroon,
                              fontWeight: FontWeight.w700),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 30,),
              //  order status box
              Row(
                children: [
                  //progress column
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle, color: Colors.green, size: 20,),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 5),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "#",
                        //         textColor: OrderStatus == 0 ||
                        //             OrderStatus == 1 || OrderStatus == 2 ||
                        //             OrderStatus == 4
                        //             ? appColors.bgreen
                        //             : appColors.darkGrey,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ),
                        //   ],
                        // ),
                        DottedLine(
                          dashColor:  OrderStatus==1||OrderStatus==4? appColors.bgreen:appColors.darkGrey,
                          lineLength: 105,
                          dashGapLength: 8,
                          dashRadius: 5,
                          lineThickness: 3,
                          direction: Axis.vertical,
                        ),
                        OrderStatus == 1 || OrderStatus == 2 || OrderStatus == 4
                            ? Icon(Icons.check_circle, color: appColors.bgreen,
                          size: 20,)
                            : Icon(
                          Icons.circle_outlined, color: appColors.bgreen,
                          size: 20,),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor:OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor:OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor:OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor:OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|", textColor:
                        //       OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,fontSize: 8,fontWeight: FontWeight.w700,),
                        //     ),
                        //
                        //   ],
                        // ),
                        DottedLine(
                          dashColor:  OrderStatus==2||OrderStatus==4? appColors.bgreen:appColors.darkGrey,
                          lineLength: 105,
                          dashGapLength: 8,
                          dashRadius: 5,
                          lineThickness: 3,
                          direction: Axis.vertical,
                        ),
                        OrderStatus == 2 || OrderStatus == 4
                            ? Icon(Icons.check_circle, color: appColors.bgreen,
                          size: 20,)
                            : Icon(
                          Icons.circle_outlined, color: appColors.bgreen,
                          size: 20,),
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w900,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|",
                        //         textColor: Colors.green,
                        //         fontSize: 8,
                        //         fontWeight: FontWeight.w700,),
                        //     ), Padding(
                        //       padding: const EdgeInsets.symmetric(vertical: 3),
                        //       child: myText(title: "|", textColor: Colors.green,
                        //         fontSize: 8, fontWeight: FontWeight.w700,),
                        //     ),
                        //   ],
                        // ),
                        DottedLine(
                          dashColor: OrderStatus==2? appColors.bgreen:appColors.darkGrey,
                          lineLength: 105,
                          dashGapLength: 8,
                          dashRadius: 5,
                          lineThickness: 3,
                          direction: Axis.vertical,
                        ),
                        OrderStatus == 2
                            ? Icon(Icons.check_circle, color: appColors.bgreen,
                          size: 20,)
                            : Icon(
                          Icons.circle_outlined, color: appColors.bgreen,
                          size: 20,),
                      ],
                    ),
                  ),
                  SizedBox(width: 25,),
                  //  status wise progress
                  Column(

                    children: [
                      SizedBox(height: 5,),
                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/placeOrder.png", height: 60, width: 45,),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: myText(title: "Your Order Has Been Placed.",
                              textColor: appColors.textBrown2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                      SizedBox(height: 55,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/packet.png", height: 60, width: 45,),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: myText(title: "We are packin your items...",
                              textColor: appColors.textBrown2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                      SizedBox(height: 60,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/scooter.png", height: 60, width: 45,),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.5,
                              child: myText(
                                title: "Your order is delivering to your location...",
                                textColor: appColors.textBrown2,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                maxLines: 3,),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 55,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/handPack.png", height: 60, width: 45,),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: myText(title: "Your Order Is Received.",
                              textColor: appColors.textBrown2,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis,),
                          ),
                          SizedBox(width: 40,),
                        ],
                      ),


                    ],

                  ),

                ],
              ),
              SizedBox(height: 40,),
              // item , sub total , del charge , total amou row
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: appColors.backgroundWhite,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: appColors.shadow, blurRadius: 15)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Column(

                    children: [
                      // items And subtotal row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Row(
                            children: [
                              myText(title: "Items :  ",
                                myStyle: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              myText(
                                title: orderlistdata!.data!.ongoing!.totalItems
                                    .toString(),
                                myStyle: TextStyle(fontSize: 14,
                                    color: appColors.maroon,
                                    fontWeight: FontWeight.w700),),
                            ],
                          ),
                          Row(
                            children: [
                              myText(title: "Sub total :  ",
                                myStyle: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              myText(
                                title: orderlistdata!.data!.ongoing!.totalAmount
                                    .toString(),
                                myStyle: TextStyle(fontSize: 14,
                                    color: appColors.maroon,
                                    fontWeight: FontWeight.w700),),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      // del charge , and total amount row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              myText(title: "Delivery Charge :  ",
                                myStyle: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              myText(title: orderlistdata!.data!.ongoing!
                                  .deliveryCharge.toString(),
                                myStyle: TextStyle(fontSize: 14,
                                    color: appColors.maroon,
                                    fontWeight: FontWeight.w700),),
                            ],
                          ),

                          Row(
                            children: [
                              myText(title: "Total Amount:  ",
                                myStyle: TextStyle(fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),),
                              myText(title: totalPrice(),
                                myStyle: TextStyle(fontSize: 16,
                                    color: appColors.appOrange,
                                    fontWeight: FontWeight.w700),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ) : Center(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Image.asset(
                "images/noOngoingImage.png",
                width: MediaQuery
                    .of(context)
                    .size
                    .height / 2.5,
              ),
              SizedBox(height: 50,),
              SizedBox(child: Center(child: myText(
                title: "There is no ongoing order right now. You can order from home",
                myStyle: TextStyle(color: appColors.maroon,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                maxLines: 3,
                textAlign: TextAlign.center,)),),
            ],
          ),
        )),
      ),
    );
  }

  void OrderListApi() async {
    Loaded = true;
    setState(() {

    });
    final queryParameters = {
      "user_id": await ValueStore().secureReadData("currentUser"),


    };

    var res = await http.post((Uri.https(
        apiIp.ipAddress, '/glossary/api/myorders', queryParameters)));


    var orderlistJson = await jsonDecode(res.body);

    print(orderlistJson);

    if (orderlistJson['success'] = true) {
      orderlistdata = OrderListModel.fromJson(orderlistJson);
      OrderStatus = orderlistdata.data!.ongoing!.status!;
      print(orderlistdata);

      Loaded = false;
      var y = DateTime.now().subtract(Duration(hours: 24));
      DateTime x = DateTime.parse(
          orderlistdata.data!.myoder!.first!.createdAt.toString());
      print(x.toString() + "VALUE OF CREATE");
      print(y.toString() + "VALUE OF NOW");
      if (x.isAfter(y)) {
        _visible = true;
      } else {
        _visible = false;
      }
      setState(() {

      });
    }
  }


  totalPrice() {
    double x = double.parse(
        orderlistdata!.data!.myoder!.first.totalAmount.toString());
    double y = double.parse(
        orderlistdata!.data!.myoder!.first.deliveryCharge.toString());
    double z = x + y;
    return z.toString();
  }

}


class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/orderPerson.png"),
            ),
          )
        ],
      ),
    );
  }
}

