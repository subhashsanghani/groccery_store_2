import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CallApi.dart';
import 'package:groccery_store_2_2/Components/urlEndPoint.dart';
import 'package:groccery_store_2_2/Models/CartListModel.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/BranchDetailsScreen.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/PaymentDelivery.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

import '../Components/ColorsFile.dart';

class CartFragment extends StatefulWidget {

   CartFragment({Key? key}) : super(key: key);


  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {

  RoundedLoadingButtonController checkcontroller = RoundedLoadingButtonController();
  GetStorage myStorage = new GetStorage();
  ScrollController _scrollController= ScrollController();
  int i = 1;
  bool loader= false;
  var data = CartListModel();

  double boxX = -1.2;
  double boxY = 0;
  bool myAnim=false;
  RoundedLoadingButtonController btnControllerShoping2 =RoundedLoadingButtonController();
  var jsonData;

  int TotalPrice =0 ;
  void _incrementCounter() {
    setState(() {
      boxX = 1;
      boxY = 0;
      i++;
    });
  }
  void decrementCounter() {
    setState(() {
      if(i!=0 )
        i--;
    });
  }

  CartListModel? cartListData;
  var iconContainerHeight = 55.00;


  void _scrollListener() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (iconContainerHeight != 0)
        setState(() {
          iconContainerHeight = 0;
        });
    }
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse  ) {
      if (iconContainerHeight == 0)
        setState(() {
          iconContainerHeight = 55;
        });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    CartListApi2();
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_scrollListener);
  }

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
        title:  myText(title: "Cart", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: loader==true?Center(child: CircularProgressIndicator(color: appColors.appOrange,)):
      cartListData!.data!= null?Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,

            child: Column(
              children: [
                // SizedBox(height: 55,),
                // // back button
                // Padding(
                //   padding:   EdgeInsets.symmetric(horizontal: 16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Align(
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
                //
                //       Padding(
                //         padding:   EdgeInsets.only(left: 40.0),
                //         child: myText(title: "Cart", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //       ),
                //
                //       Container(
                //           height: 30,
                //           padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                //           decoration: BoxDecoration(
                //               color: appColors.backgroundWhite,
                //               borderRadius: BorderRadius.circular(5),
                //               border: Border.all(width: 1, color: appColors.appOrange)
                //           ),
                //           child: MaterialButton(
                //               padding: EdgeInsets.zero,
                //               onPressed: (){
                //                 CartClear();
                //               },
                //               child: myText(title: "Clear Cart", textColor: appColors.textBrown2,fontSize: 16,fontWeight: FontWeight.w500,))),
                //     ],
                //   ),
                // ),

                SizedBox(height: 20,),
                //  cart list
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: cartListData!.data!.cart!.length,
                  itemBuilder: (context, index) {
                    return   Column(
                      children: [
                        Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 1/5,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (value){
                                  CartItemDeleteApi(index , cartListData!.data!.cart!);
                                },
                                backgroundColor: appColors.maroon,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,

                              )
                            ],
                          ),
                          // main box
                          child: SizedBox(
                            height: 110,
                            child: Padding(
                              padding:   EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // product image
                                  SizedBox(height: 75, width: 75,
                                      child:CachedNetworkImage(
                                        imageUrl: cartListData!.data!.cart![index].imageUrl.toString(),
                                        placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                                        errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                                      )
                                  ),

                                  SizedBox(width: 15,),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // name
                                      SizedBox(
                                          width: MediaQuery.of(context).size.width/2.3,
                                          child: myText(title: cartListData!.data!.cart![index].title, textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,)),
                                      // counter + ,-
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Stack(
                                              children: [
                                                //container with light orange border
                                                Container(
                                                  height: 32,
                                                  width: 98,
                                                  decoration: BoxDecoration(

                                                      color: appColors.Ishadow,
                                                      borderRadius: BorderRadius.circular(30) ),
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: GestureDetector(
                                                              onTap: () {
                                                                // demandApi(index, demandController.text);
                                                                // minusItemApi(index);
                                                              },
                                                              child: Padding(
                                                                padding:   EdgeInsets.only(left: 3.0),
                                                                child: Container(
                                                                    height: 25,
                                                                    width: 25,
                                                                    decoration: BoxDecoration(
                                                                      color: appColors.backgroundWhite,
                                                                      borderRadius: BorderRadius.circular(25),
                                                                      boxShadow: [BoxShadow(color: appColors.brownshadow, offset: Offset(0,2) ,blurRadius: 2 , spreadRadius: 1.5)],
                                                                    ),
                                                                    child: GestureDetector(
                                                                        onTap: () {
                                                                          cartListData!.data!.cart![index].qty==1?"":
                                                                          UpdateItemApi( cartListData!.data!.cart![index], "-");
                                                                        },
                                                                        child: Icon(Icons.remove,color: appColors.textBrown2,size: 25))),
                                                              ))),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: myText(title: cartListData!.data!.cart![index].qty.toString(),
                                                            textColor:appColors.textBrown2,
                                                            fontWeight: FontWeight.w400,fontSize: 18,)),
                                                      Align(
                                                          alignment:Alignment.centerRight,

                                                          child: GestureDetector(
                                                              onTap: () {


                                                                setState(() {

                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:   EdgeInsets.only(right:3),
                                                                child: Container(
                                                                    height: 25,
                                                                    width: 25,
                                                                    decoration: BoxDecoration(
                                                                      color: appColors.backgroundWhite,
                                                                      borderRadius: BorderRadius.circular(25),
                                                                      boxShadow: [BoxShadow(color: appColors.brownshadow, offset: Offset(0,2) ,blurRadius: 2 , spreadRadius: 1.5)],
                                                                    ),
                                                                    child: AnimatedAlign(
                                                                      alignment:myAnim?Alignment.centerRight: Alignment.center,
                                                                      duration: Duration(milliseconds: 300),
                                                                      child: GestureDetector(
                                                                          onTap: () {


                                                                            UpdateItemApi( cartListData!.data!.cart![index], "+");
                                                                            setState(() {

                                                                            });
                                                                          },
                                                                          child: Icon(Icons.add,color: appColors.textBrown2,size: 25 ,)),
                                                                    )),
                                                              ))),


                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.arrow_back_ios, size: 12, color: appColors.textBrown257,),
                                          myText(title: "Swipe to delete", textColor: appColors.textBrown257,fontSize: 10,fontWeight: FontWeight.w400,),
                                        ],
                                      ),
                                      myText(title: "\$ "+totalPrice(index).toString(), textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w400,),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5 ,thickness: 1,color: appColors.brownshadow01,)
                      ],
                    );

                  },

                ),

                SizedBox(height: 120,),




              ],
            ),
          ),
         //total item and total
        Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 16),
              child:Container(

                height: 70,
                decoration: BoxDecoration(
                  color: appColors.backgroundWhite,
                  border: Border.all(color: appColors.appOrange),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0 , right: 16 , top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          myText(title: "Items |  ",fontSize: 14, fontWeight: FontWeight.w600,),
                          myText(title: cartListData!.data!.totalIteams.toString(),fontSize: 16, textColor: appColors.maroon,fontWeight: FontWeight.w700,)
                        ],
                      ),
                      Row(
                        children: [
                          myText(title: "Total |  ",fontSize: 14, fontWeight: FontWeight.w600,),
                          myText(title: cartListData!.data!.finaltotal.toString(),fontSize: 16, textColor: appColors.maroon,fontWeight: FontWeight.w700,)
                        ],
                      ),
                    ],

                  ),
                ),
              ),
            ),
          ) ,
          //  checkout  button
          Positioned(
            bottom: 15,
            right: 0,
            left: 0,
            child: Padding(
              padding:   EdgeInsets.symmetric(horizontal: 16),
              child: RoundedLoadingButton(
                controller: checkcontroller,
                errorColor: appColors.appOrange,
                color: appColors.appOrange,
                animateOnTap: false,
                onPressed: () {
                  openBottomSheet();

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
                        title: "Check Out",
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
        ],
      ): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // main app bar
            // Row(
            //   children: [
            //     // back button
            //     Align(
            //       alignment: Alignment.centerLeft,
            //       child: Container(
            //         height: 40,
            //         width: 40,
            //
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(40),
            //           child: MaterialButton(
            //               padding: EdgeInsets.zero,
            //               onPressed: () {
            //
            //               },
            //               child: Center(child: Icon(Icons.arrow_back_ios,
            //                 color: appColors.appOrange, size: 18,))),
            //         ),
            //       ),
            //     ),
            //
            //     Padding(
            //       padding: const EdgeInsets.only(left: 115),
            //       child: myText(title: "Cart", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            //     ),
            //   ],
            // ),
            //main list column

            Column(
              children: [
                //  image
                Image.asset('images/favourite.png' , height: 300,),

                //  text header
                myText(title: "Your Cart Is Empty", textColor: appColors.textBrown2,fontSize: 20,fontWeight: FontWeight.w700,),
                SizedBox(height: 16),
                // main text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: myText(title: "Start fall in love with some good goods .",
                      textColor: appColors.textBrown2,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.center),
                ),
                SizedBox(height: 30),

                //  start shopping button
                RoundedLoadingButton(
                  height: 50,
                  controller: btnControllerShoping2,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 0),), (route) => false);
                    setState(() {

                    });

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
                          title: "Start Shopping",
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }

  // [][][][][] bottm sheet
  void openBottomSheet() {

    showModalBottomSheet<dynamic>(
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context) => pickUpOption(total:cartListData!.data!.finaltotal.toString()),);
    print(TotalPrice.toString()+"WWWWWWWWWWWWWWWWWWW");
  }



  // [][][][][  cart list  ][][][][]

  // void  CartListApi() async{
  //
  //   loader==true;
  //   setState(() {
  //
  //   });
  //
  //   print("cartlist call");
  //   var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/cartlist')),
  //
  //       body: {
  //         "user_id": await ValueStore().secureReadData("currentUser"),
  //       });
  //
  //   var cartlistJson = await jsonDecode(res.body);
  //
  //   print(cartlistJson);
  //   if(cartlistJson['data']!=[]){
  //     cartListData =CartListModel. fromJson(cartlistJson);
  //   }else{
  //     cartListData!.data!.cart=[];
  //   }
  //
  //    print(cartlistJson);
  //    loader = false;
  //   setState(() {
  //
  //   });
  // }


  // [][][][][  cart list api ][][][][]
   void CartListApi2() async{

    loader=true;

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      var jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.cartList,
        context: context,
        callType: 'post',
        bodyParameter: {
          "user_id": await ValueStore().secureReadData("currentUser") == null
              ? ""
              : await ValueStore().secureReadData("currentUser"),
        }

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        cartListData =CartListModel. fromJson(jsonData);


        loader=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.cartList,
        context: context,
        callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
          }
      );

      print(jsonData);
      if (jsonData['code'] == 200) {
        print(jsonData);


        loader=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }


// [][][][][  clear cart  ][][][][]

  // void  CartClear() async{
  //   loader=true;
  //   setState(() {
  //
  //   });
  //
  //   var clearRes = await http.post(Uri.https(apiIp.ipAddress , "/glossary/api/clearcart"),
  //   body: {
  //     "user_id" :ValueStore().secureReadData("currentUser"),
  //       }
  //   );
  //   var clearJson = jsonDecode(clearRes.body);
  //   print(clearJson);
  //   CartListApi2();
  //   loader=false;
  //   setState(() {
  //
  //   });
  //
  // }
  void CartClear() async{

    loader=true;

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      var jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.ClearCart,
          context: context,
          callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
          }

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        CartListApi2();



        loader=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.ClearCart,
        context: context,
        callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
          }
      );

      print(jsonData);
      if (jsonData['code'] == 200) {
        print(jsonData);


        loader=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }


// [][][][][  total price caluclator  ][][][][]

  totalPrice(int index) {

    int productprice =  cartListData!.data!.cart![index].productPrice!;
    int qty =cartListData!.data!.cart![index].qty!;

    print(productprice.toString() + "oooooooooooooooooooo");
    TotalPrice = productprice* qty;
    return TotalPrice ;

    setState(() {

    });

  }



// [][][][][  item delete api  ][][][][]

  // void CartItemDeleteApi( int index, List<Cart> list) async{
  //   loader=true;
  //   setState(() {
  //
  //   });
  //   var response = await http.post(Uri.https(apiIp.ipAddress, "/glossary/api/removecartiteam"),
  //     body: {
  //     "user_id":ValueStore().secureReadData("currentUser"),
  //     "cart_id": list[index].id.toString()
  //     }
  //   );
  //   var deleteJson = jsonDecode(response.body);
  //   print(deleteJson);
  //   if(deleteJson['success']){
  //     list.removeAt(index);
  //     CartListApi2();
  //     loader=false;
  //     setState(() {
  //
  //
  //     });
  //   }
  // }
  void CartItemDeleteApi( int index, List<Cart> list) async{

    loader=true;

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      var jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.removeCart,
          context: context,
          callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
            "cart_id": list[index].id.toString()
          }

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        list.removeAt(index);
            CartListApi2();
            loader=false;


        loader=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.removeCart,
        context: context,
        callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
            "cart_id": list[index].id.toString()
          }
      );

      print(jsonData);
      if (jsonData['code'] == 200) {
        print(jsonData);


        loader=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }


  // [][][][][  item update api  ][][][][]

  // void UpdateItemApi(Cart cart,String plus) async{
  //   loader=true;
  //   setState(() {
  //
  //   });
  //
  //   var plusRes = await http.post(Uri.https(apiIp.ipAddress, '/glossary/api/updatecart'),
  //   body: {
  //     "user_id": await ValueStore().secureReadData("currentUser"),
  //     "cart_id":cart.id.toString(),
  //     "qty":plus=="+"? "${cart.qty!+1}": "${cart.qty!-1}"
  //   }
  //   );
  //
  //   var plusJson = jsonDecode(plusRes.body);
  //
  //   if(plusJson['success']){
  //     cart.qty= plus=="+"?cart.qty!+1 : cart.qty!-1;
  //
  //     loader=false;
  //     setState(() {
  //       CartListApi2();
  //     });
  //   }else
  //     MotionToast(
  //       icon: Icons.close, description:plusJson['Message'], color: appColors.hint,
  //       animationCurve: Curves.bounceInOut,
  //       animationDuration: Duration(milliseconds: 100),
  //       toastDuration: Duration(milliseconds: 1500),
  //       animationType: ANIMATION.FROM_BOTTOM,
  //       enableAnimation: true,
  //       iconSize: 60,
  //
  //     ).show(context);
  //   loader=false;
  //   setState(() {
  //
  //   });
  // }
  void UpdateItemApi(Cart cart,String plus) async{

    loader=true;

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      var jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.updateCart,
          context: context,
          callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
            "cart_id":cart.id.toString(),
            "qty":plus=="+"? "${cart.qty!+1}": "${cart.qty!-1}"
          }

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        cart.qty= plus=="+"?cart.qty!+1 : cart.qty!-1;

            loader=false;
            setState(() {
              CartListApi2();
            });




        loader=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.updateCart,
        context: context,
        callType: 'post',
          bodyParameter: {
            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
            "cart_id":cart.id.toString(),
            "qty":plus=="+"? "${cart.qty!+1}": "${cart.qty!-1}"
          }
      );

      print(jsonData);
      MotionToast(
              icon: Icons.close, description:jsonData['Message'], color: appColors.hint,
              animationCurve: Curves.bounceInOut,
              animationDuration: Duration(milliseconds: 100),
              toastDuration: Duration(milliseconds: 1500),
              animationType: ANIMATION.FROM_BOTTOM,
              enableAnimation: true,
              iconSize: 60,

            ).show(context);
        loader=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }



class pickUpOption extends StatefulWidget {

  String total;
    pickUpOption({Key? key, required this.total}) : super(key: key);


  @override
  State<pickUpOption> createState() => _pickUpOptionState();
}

class _pickUpOptionState extends State<pickUpOption> {

  @override
  Widget build(BuildContext context) {
    return    Wrap(
      children: [

        Container(
          decoration: BoxDecoration(
              color: appColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: appColors.shadow, blurRadius: 2,)
              ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight:  Radius.circular(25))),
          child: Padding(
            padding:   EdgeInsets.symmetric(horizontal: 24 , vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myText(title:"Please Select Type Of Order !", fontSize: 22, fontWeight:FontWeight.w500, textColor: Colors.black,  maxLines: 3, textAlign: TextAlign.start,),

                SizedBox(height: 20,),
                //pick up option
                Padding(
                  padding:   EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:appColors.backgroundWhite,
                        border: Border.all(color: appColors.appOrange, width: 1)

                    ),
                    child:   ClipRRect(
                      borderRadius:  BorderRadius.circular(10),
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BranchDetailsScreen(total:widget.total.toString()),));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(title:"Pick Up", fontSize:20, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                            Image.asset("images/handPack.png" , height: 30, width: 30,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                //delivery option
                Padding(
                  padding:   EdgeInsets.symmetric(vertical: 10),
                  child: Container(

                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:appColors.backgroundWhite,
                        border: Border.all(color: appColors.appOrange, width: 1)

                    ),
                    child:   ClipRRect(
                      borderRadius:  BorderRadius.circular(10),
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentDelivery(total:widget.total.toString()),));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(title:"Delivery", fontSize:20, fontWeight: FontWeight.w700, textColor: appColors.textBrown2,),
                             Image.asset("images/scooter.png" , height: 30, width: 30,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),





              ],
            ),
          ),
        ),
      ],
    );
  }




}