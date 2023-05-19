import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CheckedCalls.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Models/CategoriesModel.dart';
import 'package:groccery_store_2_2/Models/PopularListModel.dart';
import 'package:groccery_store_2_2/Models/ProductDetailsModel.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/CartFragment.dart';
import 'package:groccery_store_2_2/pages/CategoriesItems.dart';
import 'package:groccery_store_2_2/pages/HomeFragment.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class ItemDescription extends StatefulWidget {
  String product_id;
  ProductPrice? selectedValue;

  ItemDescription({Key? key, required this.product_id, this.selectedValue})
      : super(key: key);

  @override
  State<ItemDescription> createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  final RoundedLoadingButtonController btnControllerATC =
  RoundedLoadingButtonController();
  GetStorage getStorage = GetStorage();
  ProductDetailsModel? detailsData;
  bool isLoad = false;
  int i = 1;
  double boxX = -1.2;
  double boxY = 0;
  bool myAnim = false;
  int TotalPrice = 0;
  bool valChanged = false;
  bool _redirection = false;
  bool _viewCartEnabled = true;
  final RoundedLoadingButtonController btnControllerAC1 = RoundedLoadingButtonController();

  ProductPrices selectedSize = ProductPrices();

  void _incrementCounter() {
    setState(() {
      boxX = 1;
      boxY = 0;
      i++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (i != 1) i--;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    print(ValueStore().secureReadData("product_id" + "PID"));
    ProductDetailsApi();
    if (widget.selectedValue != null) {
      selectedSize =
          ProductPrices(
            id: widget.selectedValue!.id,
            productId: widget.selectedValue!.productId,
            productPrice: widget.selectedValue!.productPrice,
            unit: widget.selectedValue!.unit,
            unitValue: widget.selectedValue!.unitValue,

          );
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad == true
          ? Center(
          child: CircularProgressIndicator(
            color: appColors.appOrange,
          ))
          : SingleChildScrollView(
          child: Stack(
            children: [
              //item background
              Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "images/itembg.png",
                    width: 190,
                    height: 190,
                  )),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  product image
                  SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .width / 1.3,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          child:
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: detailsData!.data!.produt!.imageUrl
                                .toString(),
                            placeholder: (context, url) => Image.asset(
                                'images/placeBasket.png', height: 120,
                                width: 120,
                                fit: BoxFit.contain),
                            errorWidget: (context, url, error) => Image.asset(
                                'images/placeBasket.png', height: 120,
                                width: 120,
                                fit: BoxFit.contain),

                          ))),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // name , des , and price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //  product name
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.6,
                              child: myText(
                                title: detailsData!.data!.produt!.productName,
                                textColor: appColors.textBrown2,
                                fontSize: 22,
                                maxLines: 3,
                                fontWeight: FontWeight.w700,
                              ),
                            ),


                            //  product description
                            SizedBox(
                              height: 10,
                            ),
                            detailsData!.data!.produt!.productDescription != ""
                                ? SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.6,
                              child: myText(
                                title: detailsData!.data!.produt!
                                    .productDescription,
                                textColor: appColors.textBrown2,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                maxLines: 5,
                              ),
                            )
                                : SizedBox.shrink(),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                        //size
                        Container(
                          height: 65,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appColors.backgroundWhite,
                            border: Border.all(color: appColors.appOrange),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              onPressed: () {
                                openBottomSheet();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      myText(title: "Size",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        textColor: appColors.appOrange,),
                                      SizedBox(child: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: appColors.appOrange, size: 12,)),
                                    ],
                                  ),
                                  myText(
                                    title:
                                    selectedSize.id != null ? selectedSize
                                        .unitValue.toString() + " " +
                                        selectedSize.unit.toString() :
                                    detailsData!.data!.produt!.productPrices![0]
                                        .unitValue.toString() + "  " +
                                        detailsData!.data!.produt!
                                            .productPrices![0].unit!.toString(),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black,
                                    textOverflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //price
                        Container(
                          height: 65,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appColors.backgroundWhite,
                            border: Border.all(color: appColors.appOrange),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              onPressed: () {

                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  myText(title: "Price",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textColor: appColors.appOrange,),
                                  myText(title: "\$ " + totalPrice().toString(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black,
                                    textOverflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),
                  // counter + ,-
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: [
                              //container with light orange border
                              Container(
                                height: 50,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.3,
                                decoration: BoxDecoration(
                                    color: appColors.Ishadow,
                                    borderRadius: BorderRadius.circular(30)),
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
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: appColors
                                                        .backgroundWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        40),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: appColors
                                                              .brownshadow,
                                                          offset:
                                                          Offset(0, 3),
                                                          blurRadius: 2,
                                                          spreadRadius: 1.5)
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        decrementCounter();
                                                        if (i == 0)
                                                          myAnim = false;
                                                      },
                                                      child: Icon(
                                                          Icons.remove,
                                                          color: appColors
                                                              .textBrown2,
                                                          size: 25))),
                                            ))),
                                    Align(
                                        alignment: Alignment.center,
                                        child: myText(
                                          title: "$i",
                                          textColor: appColors.textBrown2,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        )),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                            onTap: () {
                                              // plusItemApi(index);

                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: appColors
                                                        .backgroundWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        40),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: appColors
                                                              .brownshadow,
                                                          offset:
                                                          Offset(0, 3),
                                                          blurRadius: 2,
                                                          spreadRadius: 1.5)
                                                    ],
                                                  ),
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        if (i == 0)
                                                          myAnim = true;
                                                        _incrementCounter();
                                                        setState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: appColors
                                                            .textBrown2,
                                                        size: 25,
                                                      ))),
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            var b = await checkCall()
                                .checkLogin();
                            b ? detailsData!.data!.produt!.isFavourite == 0
                                ? AddFavApi()
                                : RemoveFavApi() : MotionToast(
                              icon: Icons.info_rounded,
                              description: 'Please Login',
                              color: Colors.grey.shade400,
                              animationCurve: Curves.bounceInOut,
                              animationDuration: Duration(
                                  milliseconds: 100),
                              toastDuration: Duration(milliseconds: 1500),
                              enableAnimation: true,
                              iconSize: 60,
                            ).show(context);
                          },

                          child: detailsData!.data!.produt!.isFavourite == 0 ?
                          Icon(Icons.favorite_border_outlined,
                              color: appColors.appOrange, size: 30) : Icon(
                              Icons.favorite,
                              color: appColors.appOrange, size: 30),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  //  add to cart button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RoundedLoadingButton(
                      height: 50,
                      controller: btnControllerATC,
                      errorColor: appColors.appOrange,
                      color: appColors.appOrange,
                      animateOnTap: true,
                      onPressed: () {
                        btnControllerAC1.start();
                        setState(() {
                          i > 0
                              ? _viewCartEnabled
                              ? AddToCartApi()
                              : null
                              : null;
                        });
                      },
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.2,
                      child: myText(title: "Add To Cart",
                        fontSize: 16,
                        textColor: appColors.backgroundWhite,),

                    ),
                  ),
                  //  divider
                  SizedBox(height: 20),
                  Divider(
                    height: 5,
                    thickness: 1,
                    color: appColors.brownshadow01,
                  ),
                  SizedBox(height: 10),
                  //  you may also need
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        myText(
                          title: "You may also need",
                          textColor: appColors.textBrown2,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        MaterialButton(
                            height: 18,
                            minWidth: 40,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              CategoriesApi(detailsData!.data!.related!.first.parentCategoryId!);

                            },
                            child: myText(title: "More",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              textColor: appColors.appOrange,)),
                      ],
                    ),
                  ),
                  //  popualr list view
                  SizedBox(height: 16),
                  detailsData!.data!.related!.length == null &&
                      detailsData!.data!.related!.isEmpty &&
                      detailsData!.data!.related == [] &&
                      detailsData!.data!.related!.first == null ?
                  SizedBox(child: myText(title: "No related Products",
                    textColor: appColors.textBrown2,
                    fontSize: 16,))
                      : SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 1.8,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: detailsData!.data!.related!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 16, top: 2, bottom: 2,),
                          child: Container(
                            // height: 185,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: appColors.backgroundWhite,
                                boxShadow: [
                                  BoxShadow(
                                      color: appColors.shadow,
                                      spreadRadius: 1,
                                      blurRadius: 2)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  detailsData!.data!.related![index]
                                      .productPrices!.isNotEmpty ?
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          ItemDescription(
                                              product_id: detailsData!.data!
                                                  .related![index].productId
                                                  .toString()),)) :
                                  MotionToast(
                                    position: MOTION_TOAST_POSITION.BOTTOM,
                                    animationType: ANIMATION.FROM_LEFT,
                                    animationCurve: Curves.linear,
                                    icon: Icons.info_outline,
                                    width: 310,
                                    height: 60,
                                    description: "Product Not Available Currently",
                                    title: "",
                                    titleStyle: TextStyle(fontSize: 16),
                                    animationDuration: Duration(
                                        microseconds: 500),
                                    descriptionStyle: TextStyle(fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    toastDuration: Duration(seconds: 3),
                                    color: Colors.orange.shade500,
                                  ).show(context);
                                  ;
                                  setState(() {

                                  });
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 3.7,
                                        width:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: detailsData!.data!
                                              .related![index].imageUrl
                                              .toString(),
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  'images/placeBasket.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  'images/placeBasket.png'),

                                        )),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              myText(
                                                title: detailsData!
                                                    .data!
                                                    .related![index]
                                                    .productName,
                                                textColor:
                                                appColors.textBrown2,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width /
                                                    2.8,
                                                height: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 14,
                                                decoration: BoxDecoration(
                                                    color: appColors
                                                        .backgroundWhite,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: appColors
                                                            .appOrange)),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    // openBottomSheet();
                                                  },
                                                  padding: EdgeInsets.zero,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        myText(
                                                          title:
                                                          detailsData!.data!
                                                              .related![index]
                                                              .productPrices!
                                                              .isNotEmpty &&
                                                              detailsData!.data!
                                                                  .related![index]
                                                                  .productPrices !=
                                                                  null
                                                              ?
                                                          detailsData!.data!
                                                              .related![index]
                                                              .productPrices![0]
                                                              .unitValue
                                                              .toString() +
                                                              " " +
                                                              detailsData!.data!
                                                                  .related![index]
                                                                  .productPrices!
                                                                  .first.unit
                                                                  .toString()
                                                              : "N/A",
                                                          textColor: appColors
                                                              .darkGrey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_drop_down,
                                                          size: 15,
                                                          color: appColors
                                                              .appOrange,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width / 2.8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    myText(
                                                      title: detailsData!.data!
                                                          .related![index]
                                                          .productPrices!
                                                          .isNotEmpty ?
                                                      detailsData!.data!
                                                          .related![index]
                                                          .productPrices!.first
                                                          .productPrice
                                                          .toString() : "N/A",
                                                      textColor:
                                                      appColors.appOrange,
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                    ),
                                                    SizedBox(
                                                      width: 42,
                                                    ),
                                                    Icon(
                                                      Icons.add_circle,
                                                      size: 30,
                                                      color: appColors.bgreen,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
              // back button
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 55),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: appColors.backgroundWhite,
                        border: Border.all(color: appColors.appOrange),
                        boxShadow: [
                          BoxShadow(blurRadius: 3, color: Colors.grey)
                        ]
                    ),
                    height: 35,
                    width: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.arrow_back_ios,
                                  color: appColors.appOrange, size: 18),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void ProductDetailsApi() async {
    isLoad = true;

    final queryParameters = {
      "user_id": await ValueStore().secureReadData("currentUser"),
      "product_id": widget.product_id.toString()
    }
        .map((key, value) => MapEntry(key, value.toString()));

    print(apiIp.ipAddress + "/glossary/api/productdetails");
    var res = await http.post(
        (Uri.https(apiIp.ipAddress, '/glossary/api/productdetails',
            queryParameters)),
        headers: {"Accept": 'application/json'});
    print(res.body + "OOOOOOOOOOOOOOOOOOOOOO");
    print(res.statusCode.toString() + "Code : OOOOOOOOOOOOOOOOOOOOOO");

    var detailsListJson = await jsonDecode(res.body);
    detailsData = ProductDetailsModel.fromJson(detailsListJson);


    if (detailsData!.success!) {
      print(detailsListJson);
      isLoad = false;
      setState(() {});
    }
  }

  //add to favorite api
  void AddFavApi() async {
    // isLoad = true;
    setState(() {

    });
    var addfav = await http.post(
        Uri.https(apiIp.ipAddress, '/glossary/api/addfavorite'),
        body: {
          "user_id": await ValueStore().secureReadData("currentUser"),
          "product_id": detailsData!.data!.produt!.productId.toString(),

        }

    );
    print(await ValueStore().secureReadData("currentUser").toString() +
        "OOOOOOOOOOOOOOO");
    var AddFavJson = jsonDecode(addfav.body);

    if (AddFavJson != null && AddFavJson['success']) {
      detailsData!.data!.produt!.isFavourite = 1;
      setState(() {

      });
    }


    print(AddFavJson);
    // print(_homeData!.data!.products![index].productId.toString());
    print(addfav);

    MotionToast(
      icon: Icons.favorite,
      description: AddFavJson['message'],
      color: appColors.appOrange,
      animationCurve: Curves.bounceInOut,
      animationDuration: Duration(milliseconds: 100),
      toastDuration: Duration(milliseconds: 1500),
      animationType: ANIMATION.FROM_BOTTOM,
      enableAnimation: true,
      iconSize: 60,

    ).show(context);

    isLoad = false;
    setState(() {
      detailsData!.data!.produt!.isFavourite = 1;
    });
  }

  //remove from favourite api
  void RemoveFavApi() async {
    // isLoad= true;

    setState(() {

    });
    var remfav = await http.post(
        Uri.https(apiIp.ipAddress, '/glossary/api/deletefavorite',),

        body: {
          "user_id": await ValueStore().secureReadData("currentUser"),
          "product_id": detailsData!.data!.produt!.productId.toString(),

        }
    );
    var RemoveJson = jsonDecode(remfav.body);

    if (RemoveJson != null && RemoveJson['success']) {
      detailsData!.data!.produt!.isFavourite = 0;
      setState(() {

      });
    }


    print(RemoveJson);


    print(remfav);


    isLoad = false;

    MotionToast(
      icon: Icons.favorite,
      description: RemoveJson['message'],
      color: Colors.grey.shade400,
      animationCurve: Curves.bounceInOut,
      animationDuration: Duration(milliseconds: 100),
      toastDuration: Duration(milliseconds: 1500),
      animationType: ANIMATION.FROM_BOTTOM,
      enableAnimation: true,
      iconSize: 60,


    ).show(context);
    setState(() {


    });
  }

  //total price
  totalPrice() {
    if (detailsData != null &&
        detailsData!.data!.produt!.productPrices!.isNotEmpty) {
      int productprice = detailsData!.data!.produt!.productPrices!.first
          .productPrice!;
      if (selectedSize.id != null) {
        productprice = selectedSize.productPrice!;
      }
      if (productprice != "null")
        print(productprice.toString() + "oooooooooooooooooooo");
      TotalPrice = productprice * i;
      setState(() {

      });
      return TotalPrice;
    }
  }

  void openBottomSheet() {
    showModalBottomSheet<dynamic>(
      enableDrag: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => pickUpOption(),);
  }


  // Size Bottom Sheet @@@@@@@@@@@@@@@@@@@@@@@@

  pickUpOption() {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              color: appColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, blurRadius: 10,)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                  title: "Select Size and Quantity",
                  textColor: appColors.textBrown2,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                ListView.builder(
                  itemCount: detailsData!.data!.produt!.productPrices!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);

                        selectedSize =
                        detailsData!.data!.produt!.productPrices![index];
                        valChanged == true;
                        setState(() {});
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: appColors.backgroundWhite,
                              border: Border.all(
                                  color: appColors.appOrange, width: 0.7),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey, blurRadius: 2,)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 7),
                          margin: EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                myText(title:
                                detailsData!.data!.produt!.productPrices![index]
                                    .unitValue.toString() + " " +
                                    detailsData!.data!.produt!
                                        .productPrices![index].unit.toString(),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  textColor: Colors.black,
                                  fontfamily: "DMSans-Medium",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,),
                                myText(title: detailsData!.data!.produt!
                                    .productPrices![index].productPrice
                                    .toString(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  textColor: appColors.appOrange,
                                  fontfamily: "DMSans-Medium",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,),

                              ]
                          )),
                    );
                  },

                ),


              ],
            ),
          ),
        ),
      ],
    );
  }

  void AddToCartApi() async {
    //  _viewCartEnabled = false;
    //  btnControllerAC1.start();
    // if(mounted) setState(() {
    //
    //  });
    //
    //
    //
    //  var response = await http.post(Uri.https(apiIp.ipAddress , "/glossary/api/cart") ,
    //    body: {
    //    "user_id": ValueStore().secureReadData("currentUser"),
    //      "product_id": detailsData!.data!.produt!.productId.toString(),
    //      "qty":"$i",
    //      "price_id": selectedSize.id!= null ? selectedSize.id.toString():detailsData!.data!.produt!.productPrices!.first.id.toString(),
    //    }
    //  );
    //
    //  var AddtoCartJson = jsonDecode(response.body);
    //  print("Add to cart call");
    //  print(AddtoCartJson);
    //  print(AddtoCartJson['message']);
    //
    //  if(AddtoCartJson['success']==true){
    //    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomePage(tabPos: 2)),(route) => false,);
    //    btnControllerAC1.stop();
    //    setState(() {
    //
    //    });
    //  }
    //  else{
    //
    //    MotionToast(
    //      position: MOTION_TOAST_POSITION.BOTTOM,
    //      animationType: ANIMATION.FROM_LEFT,
    //      animationCurve: Curves.linear,
    //      icon: Icons.close,
    //      height: 60,
    //      borderRadius: 8,
    //      width: MediaQuery.of(context).size.width/1.035,
    //      description:  AddtoCartJson["message"].toString().length>32?AddtoCartJson["message"].toString().substring(0,32):AddtoCartJson["message"].toString(),
    //      title:"",
    //      titleStyle: TextStyle(fontSize: 14),
    //      animationDuration: Duration(microseconds: 300),
    //      descriptionStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100, color: Colors.black45),
    //      toastDuration: Duration(seconds: 2),
    //      color: Colors.red.shade500,
    //    ).show(context);
    //
    //    btnControllerAC1.stop();
    //   if(mounted) setState(() {
    //
    //    });
    //  }

    _viewCartEnabled = false;
    btnControllerAC1.start();

    if (await ValueStore().secureReadData("isLoggedIn") == "yes") {
      setState(() {
        _redirection = true;
      });

      var response = await http.post(
          Uri.https(apiIp.ipAddress, "/glossary/api/cart"),
          body: {
            "user_id": await ValueStore().secureReadData("currentUser"),
            "product_id": detailsData!.data!.produt!.productId.toString(),
            "qty": "$i",
            "price_id": selectedSize.id != null
                ? selectedSize.id.toString()
                : detailsData!.data!.produt!.productPrices!.first.id.toString(),
          }
      );

      var addCartjson = jsonDecode(response.body);
      if (addCartjson['success'] == true) {
        btnControllerAC1.stop();
        MotionToast(
          icon: Icons.done,
          description: addCartjson['message'],
          color: appColors.bgreen,
          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 100),
          toastDuration: Duration(milliseconds: 1500),

          enableAnimation: true,
          iconSize: 60,
        ).show(context);
        Future.delayed(
            Duration(seconds: 2),
                () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(tabPos: 2),
                    )));
        _redirection = false;
      } else {
        _viewCartEnabled = true;
        btnControllerAC1.stop();
        print("Something Went Wrong in add cart");
        _redirection = false;
      }
    } else
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SignIn(refScreen: 'proDetails'),
        ),
            (route) => false,
      );
  }


  void CategoriesApi(int s) async {
    isLoad = true;
    var res = await http.get(
      (Uri.https(apiIp.ipAddress, '/glossary/api/categories')),

    );

    var CategoriestJson = await jsonDecode(res.body);

   if(CategoriestJson['success']==true){
     print(s.toString()+"ABCD");
     CategoriesModel _categoriesData = CategoriesModel.fromJson(CategoriestJson);
     print(CategoriestJson);
     List<SubCat> subCatList=_categoriesData.data!.category!.where((element) => element.id== s).first.subCat!.toList();
     print(subCatList.toString()+"AAAAAAAAAAAAAAAAAAAAAAA");
     Navigator.push(context, MaterialPageRoute(
       builder: (context) => CategoriesItems(subCatList: subCatList),));
   }
    setState(() {
      isLoad = false;
    });
  }


}
