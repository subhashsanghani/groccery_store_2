import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CallApi.dart';
import 'package:groccery_store_2_2/Components/urlEndPoint.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/main.dart';
import 'package:groccery_store_2_2/pages/HomeFragment.dart';
import 'package:groccery_store_2_2/pages/ItemDescription.dart';
import 'package:groccery_store_2_2/pages/SearchScreen.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../Components/ColorsFile.dart';
import '../Models/CategoriesItemsModel.dart';
import '../Models/CategoriesModel.dart';
import 'package:http/http.dart' as http;
class CategoriesItems extends StatefulWidget {
   List<SubCat> subCatList;
   CategoriesItems({Key? key, required this.subCatList}) : super(key: key);

  @override
  State<CategoriesItems> createState() => _CategoriesItemsState();
}

class _CategoriesItemsState extends State<CategoriesItems> with SingleTickerProviderStateMixin {

  late TabController tabController;
  CategoriesItemsModel? categoriesItemsData;
  bool isLoad = false;
  int selectedCat =0;
  GetStorage store = GetStorage();
  List<Product> selectedSubPro=[];




  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this, initialIndex: 0);
    selectedCat= widget.subCatList.first.id!;
    CategoriesItemsApi();

  }

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
            margin: EdgeInsets.only(left: 20 , top: 0),

            child: Icon(Icons.arrow_back_ios,
              color: appColors.appOrange, size: 18),

          ),
        ),
        title:  myText(title: "Categories", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:isLoad==true ? Center(child: CircularProgressIndicator(color: appColors.appOrange,)) :
      SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // SizedBox(height: 55,),

            // main app bar
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Row(
            //     children: [
            //       // back button
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10.0),
            //         child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: Container(
            //             height: 40,
            //             width: 40,
            //
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(40),
            //               child: MaterialButton(
            //                   padding: EdgeInsets.zero,
            //                   onPressed: () {
            //
            //                   },
            //                   child: Center(child: Icon(Icons.arrow_back_ios,
            //                     color: appColors.appOrange, size: 18,))),
            //             ),
            //           ),
            //         ),
            //       ),
            //       SizedBox(width: 60,),
            //       myText(title: "Categories", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            //     ],
            //   ),
            // ),
            SizedBox(height: 18,),
            //search bar
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
                },
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: appColors.borderGrey,
                    border: Border.all(color: appColors.borderGrey),
                  ),
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: EdgeInsets.all(7),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35)
                          ),
                          child: (Icon(Icons.search_rounded, color: appColors.textBrown257,)),
                        ),
                      ),
                      SizedBox(width: 15,),
                      myText(title: "search", textColor: appColors.textBrown257,fontSize: 16,fontWeight: FontWeight.w400,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          //  tab bar of categories
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: appColors.borderGrey, width: 1))
              ),
              child: TabBar(
               isScrollable: true,
                onTap: (val){
                 selectedCat=widget.subCatList[val].id!;
                 CategoriesItemsApi();
                 store.write("catId", selectedCat);
                 setState(() {

                 });
                               },
                indicatorWeight: 3,
                // padding: EdgeInsets.symmetric(horizontal: 16),
                labelPadding: EdgeInsets.symmetric(horizontal: 16),
                controller: tabController,
                labelColor: appColors.textBrown2,
                indicatorColor: appColors.appOrange,
                labelStyle: TextStyle(color: appColors.textBrown2 , fontSize: 16 , fontWeight: FontWeight.w400),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [

                  for(int a = 0 ; a< widget.subCatList.length ; a++)

                   Tab(text: widget.subCatList[a].title, ),


                ],
              ),
            ),
          //grid items
            SizedBox(height: 16,),
            SizedBox(
              height: MediaQuery.of(context).size.height/1.56,
              child: selectedSubPro.length!=null?GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: 16),
                 shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 250,
                    childAspectRatio: 10),
                itemCount: selectedSubPro.length,
                itemBuilder: (context, index) {
                  print(selectedSubPro.length.toString()+"QQQQQQQQQQQ");
                  return productView(context: context,products:selectedSubPro,position:index);
                },
              ):Center(child: Container(
                height:  MediaQuery.of(context).size.width/1.6,
                width: MediaQuery.of(context).size.width,
                child: myText(title: "No Products Available",fontSize: 17 , fontWeight: FontWeight.w700 , textColor: appColors.textBrown2 , ),)),
            ),

          ],
        ),
      ),
    );
  }

  // [][][][][  categories item api   ][][][][]

  // void CategoriesItemsApi() async{
  //
  //   print(selectedCat.toString()+">>>>>>>");
  //   final queryParameters = {
  //    "cat_id":selectedCat.toString()
  //   };
  //    isLoad = true;
  //   print(apiIp.ipAddress+"/glossary/api/products?cat_id=10");
  //   var res = await http.post(( Uri.http(apiIp.ipAddress, '/glossary/api/products',queryParameters )),
  //   headers: {
  //     "Accept":'application/json'
  //   }
  //   );
  //   print(res.body+"OOOOOOOOOOOOOOOOOOOOOO");
  //   print(res.statusCode.toString()+"Code : OOOOOOOOOOOOOOOOOOOOOO");
  //
  //
  //
  //   var CategoriestJson = await jsonDecode(res.body);
  //   categoriesItemsData =CategoriesItemsModel.fromJson(CategoriestJson);
  //   selectedSubPro = categoriesItemsData!.data!.product!;
  //   if(categoriesItemsData!.success!){
  //
  //   }
  //   print(CategoriestJson);
  //   setState(() {
  //     isLoad = false;
  //
  //   });
  // }
  void CategoriesItemsApi() async{

    isLoad=true;
    setState(() {

    });

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      var jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.categoriesData,
          context: context,
          callType: 'post',
          bodyParameter: {
            "cat_id":selectedCat.toString()
          }

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        categoriesItemsData =CategoriesItemsModel.fromJson(jsonData);
           selectedSubPro = categoriesItemsData!.data!.product!;
        isLoad=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
     var jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.cartList,
        context: context,
        callType: 'post',
         bodyParameter: {
           "cat_id":selectedCat.toString()
         }
      );

      print(jsonData);
      if (jsonData['code'] == 200) {
        print(jsonData);


        isLoad=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }

  Widget productView({required BuildContext context, required List<Product> products, required int position}) {
    return  Container(
      // height: 185,
      margin: EdgeInsets.only(top: 5),
      width:  MediaQuery.of(context).size.width/2.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: appColors.backgroundWhite,
          boxShadow: [BoxShadow(color: appColors.shadow, spreadRadius: 1 , blurRadius: 2 , offset: Offset(-1,1))]

      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: (){
            categoriesItemsData!.data!.product![position].productPrices!.isNotEmpty? Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription(product_id: categoriesItemsData!.data!.product![position].productId.toString()),)):
            MotionToast(
              position: MOTION_TOAST_POSITION.BOTTOM,
              animationType: ANIMATION.FROM_LEFT,
              animationCurve: Curves.linear,
              icon: Icons.info_outline,
              width: 310,
              height: 60,
              description:"Product Not Available Currently",
              title: "",
              titleStyle: TextStyle(fontSize: 16),
              animationDuration: Duration(microseconds: 500),
              descriptionStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
              toastDuration: Duration(seconds: 3),
              color: Colors.orange.shade500,
            ).show(context);
            store.write("selProId", products[position].productId);
          },
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              SizedBox(
                  height: MediaQuery.of(context).size.width/3.6,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:products[position].imageUrl.toString(),
                    placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                    errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                  )),

              Padding(
                padding: const EdgeInsets.only(left: 10.0 , right: 10 , top: 0 , bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width/2.7,
                            height: MediaQuery.of(context).size.width/11,
                            child: myText(title: products[position].productName, textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w700,)),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width/2.65,
                          height: MediaQuery.of(context).size.width/14,
                          decoration: BoxDecoration(
                              color: appColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1 ,color: appColors.appOrange)
                          ),
                          child: MaterialButton(
                            onPressed: (){
                                openBottomSheet(index: position, products: categoriesItemsData!.data!.product!);
                            },
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(title: categoriesItemsData!.data!.product![position].selectedPrice!=null?categoriesItemsData!.data!.product![position].selectedPrice!.unitValue.toString()+" "+categoriesItemsData!.data!.product![position].selectedPrice!.unit.toString():
                                  categoriesItemsData!.data!.product![position].productPrices!.first.unitValue.toString()+" "+categoriesItemsData!.data!.product![position].productPrices!.first.unit.toString() ,
                                    textColor: appColors.darkGrey,fontSize: 12,fontWeight: FontWeight.w400,),
                                  Icon(Icons.arrow_drop_down, size: 15,color: appColors.appOrange,)

                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/2.65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width/3.6,
                                  child: myText(title:categoriesItemsData!.data!.product![position].selectedPrice!=null?categoriesItemsData!.data!.product![position].selectedPrice!.productPrice.toString():
                                  categoriesItemsData!.data!.product![position].productPrices!.isNotEmpty?
                                  currencySymbol+" "+  categoriesItemsData!.data!.product![position].productPrices![0].productPrice.toString(): "N/A", textColor: appColors.appOrange,fontSize: 18,fontWeight: FontWeight.w600,)),
                              categoriesItemsData!.data!.product![position].productPrices!.isNotEmpty && categoriesItemsData!.data!.product![position].productPrices!.first.unitValue.toString() != "0"?
                              Icon(Icons.add_circle, size: 30,color: appColors.bgreen,):SizedBox(height: 30,)
                            ],
    
                          ),
    
                        ),

                      ],
                    ),

                  ],
                ),
              )





            ],
          ),
        ),
      ),
    );
  }

  // [][][][][] bottm sheet
  void openBottomSheet({required int index, required List<Product> products}) {

    showModalBottomSheet<dynamic>(

      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context) => pickUpOption(products:products , index:index),);
  }



  pickUpOption(  {required List<Product> products, required int index , }){


    return  Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
              color: appColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: appColors.shadow, blurRadius: 2,)
              ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight:  Radius.circular(25))),
          constraints: BoxConstraints(maxHeight: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  myText(title:"Please Select Quantity !", fontSize: 22, fontWeight:FontWeight.w500, textColor: Colors.black,  maxLines: 3, textAlign: TextAlign.start,),
                  SizedBox(height: 10,),
                  SizedBox(height: 175, width: MediaQuery.of(context).size.width, child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    imageUrl:products[index].imageUrl.toString(),
                    placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                    errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                  )),
                  SizedBox(height: 15,),
                  myText(title: products[index].productName.toString(), textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w700,),
                  SizedBox(height: 15,),
                  SizedBox(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products[index].productPrices!.length,
                      itemBuilder: (context, index2) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Expanded(
                              child: Container(

                                height: 40,
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


                                      Navigator.pop(context);


                                      categoriesItemsData!.data!.product![index].selectedPrice = categoriesItemsData!.data!.product![index].productPrices![index2];
                                      setState(() {

                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        myText(title:products[index].productPrices![index2].unitValue.toString()+" "+products[index].productPrices![index2].unit.toString()
                                          , fontSize:18, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                                        myText(title: currencySymbol.toString()+products[index].productPrices![index2].productPrice.toString(), textColor: appColors.appOrange,fontSize: 20,fontWeight: FontWeight.w700,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },),
                  ),




                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


}


