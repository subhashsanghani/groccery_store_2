

import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CallApi.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Components/SettingsModel.dart';
import 'package:groccery_store_2_2/Components/urlEndPoint.dart';
import 'package:groccery_store_2_2/Components/valueStore.dart';
import 'package:groccery_store_2_2/Models/PopularListModel.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/main.dart';
import 'package:groccery_store_2_2/pages/CategoriesItems.dart';
import 'package:groccery_store_2_2/pages/ExploreFragment.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/ItemDescription.dart';
import 'package:groccery_store_2_2/pages/SearchScreen.dart';
import 'package:http/http.dart' as http;

import '../Models/CategoriesItemsModel.dart';
import '../Models/CategoriesModel.dart';


PopularListModel? popularData =  PopularListModel();
CategoriesModel? categoriesData;



class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}
ProductPrice selectedSize = ProductPrice();
final FirebaseMessaging _firebaseMessaging= FirebaseMessaging.instance ;

class _HomeFragmentState extends State<HomeFragment> {
   bool isLoad = false;
  var jsonData;
  GetStorage Store1 = GetStorage();
  SettingsModel settingsData =SettingsModel();



  @override
  void initState() {
    // TODO: implement initState


    CategoriesApi();

    // getDeviceTokenToSendNotification();




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundWhite,
      body: isLoad ==true?
      Center(child: CircularProgressIndicator(color: appColors.appOrange,)):
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60,),
            //Search and filter bar
            myText(title: "Grocery Store", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            SizedBox(height: 25,),
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
                      myText(title: "Search Products", textColor: appColors.textBrown257,fontSize: 16,fontWeight: FontWeight.w400,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          //  Categories text and see all row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(title: "Categories", textColor: appColors.textBrown2,fontSize: 22,fontWeight: FontWeight.w700,),
                  Padding(
                    padding:  EdgeInsets.zero,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(tabPos: 1),));
                        },
                        child: myText(title: "See All", textColor: appColors.appOrange,fontSize: 18,fontWeight: FontWeight.w400,)),
                  )

                ],
              ),
            ),
            SizedBox(height: 15),
            //  Categories listview
            SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child:
              ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: categoriesData!.data!.category!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MaterialButton(
                        padding: EdgeInsets.only( left:index==0?16:10,top: 0 ,right:10 , bottom: 0 ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesItems(subCatList:categoriesData!.data!.category![index].subCat! ),));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.grey , blurRadius: 3)],
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: categoriesData!.data!. category![index].imageUrl.toString(),
                                      placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                                      errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                                    )
                                )
                            ),

                            SizedBox(height: 10,),
                            SizedBox(
                                width: 100,
                                height: 40,
                                child: myText(title: categoriesData!.data!.category![index].title,fontSize: 15,fontWeight: FontWeight.w400,textColor: appColors.textBrown2, maxLines: 3,textAlign: TextAlign.center,))


                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
          //  popular deals text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  myText(title: "Popular Deals", textColor: appColors.textBrown2,fontSize: 22,fontWeight: FontWeight.w700,),
                  MaterialButton(

                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(tabPos: 1),));
                      },
                      child: myText(title: "See All", textColor: appColors.appOrange,fontSize: 18,fontWeight: FontWeight.w400,))

                ],
              ),
            ),
          //  popualr list view
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.width/1.7,
              width: MediaQuery.of(context).size.width,
              child:
             popularData!.data!.products!=null ? ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: popularData!.data!.products!.length!=null?popularData!.data!.products!.length:0 ,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(left:16 , top: 10 ,bottom: 5),
                    child: Container(
                      // height: 185,
                      width: MediaQuery.of(context).size.width/2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: appColors.backgroundWhite,
                        boxShadow: [BoxShadow(color: appColors.shadow, spreadRadius: 1 , blurRadius: 3)]

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: ()async{
                            popularData!.data!.products![index].productPrice!.isNotEmpty && popularData!.data!.products![index].productPrice!.first.unitValue.toString()!= "0"?
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription(product_id:popularData!.data!.products![index].productId.toString() , selectedValue:popularData!.data!.products![index].selectedPrice ),))
                            : null;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [

                                SizedBox(height: MediaQuery.of(context).size.width/3.7,
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: popularData!.data!.products![index].imageUrl.toString(),
                                      placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                                      errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                                    )
                                ),



                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0 , right: 10 , bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context).size.width/14,
                                              width: MediaQuery.of(context).size.width/3,
                                              child: myText(title: popularData!.data!.products![index].productName,
                                                textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w700,maxLines: 3, textAlign: TextAlign.start,)),
                                          SizedBox(height: 5,),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2.8,
                                            height: MediaQuery.of(context).size.width/14,
                                            decoration: BoxDecoration(
                                                color: appColors.backgroundWhite,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 1 ,color: appColors.appOrange)
                                            ),
                                            child: MaterialButton(
                                              onPressed: (){
                                                openBottomSheet(index:index, products: popularData!.data!.products!);
                                              },
                                              padding: EdgeInsets.zero,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    myText(title: popularData!.data!.products![index].selectedPrice!=null?popularData!.data!.products![index].selectedPrice!.unitValue.toString()+" "+popularData!.data!.products![index].selectedPrice!.unit.toString():
                                                    popularData!.data!.products![index].productPrice!.first.unitValue.toString()+" "+popularData!.data!.products![index].productPrice!.first.unit.toString() ,
                                                      textColor: appColors.darkGrey,fontSize: 12,fontWeight: FontWeight.w400,),
                                                    Icon(Icons.arrow_drop_down, size: 15,color: appColors.appOrange,)

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context).size.width/3.6,
                                                  child: myText(title:popularData!.data!.products![index].selectedPrice!=null?popularData!.data!.products![index].selectedPrice!.productPrice.toString():
                                                  popularData!.data!.products![index].productPrice!.isNotEmpty?
                                                currencySymbol+" "+  popularData!.data!.products![index].productPrice![0].productPrice.toString(): "N/A", textColor: appColors.appOrange,fontSize: 18,fontWeight: FontWeight.w600,)),
                                              popularData!.data!.products![index].productPrice!.isNotEmpty && popularData!.data!.products![index].productPrice!.first.unitValue.toString() != "0"?
                                              Icon(Icons.add_circle, size: 30,color: appColors.bgreen,):SizedBox(height: 30,)
                                            ],
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
                      ),
                    ),
                  );
                },
              ):
              Center(child: SizedBox(
                  height: 40,
                  child: myText(title: "No Popular Products Currently",myStyle: TextStyle(fontSize: 18 , color: appColors.textBrown2)))),
            ),


          ],
        ),
      ),
    );
  }

  // [][][][][] bottm sheet

  void openBottomSheet({required int index, required List<Products> products}) {

    showModalBottomSheet<dynamic>(

      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context, builder: (context) => pickUpOption(products:products , index:index),);
  }

  // [][][][---- APIS FOR HOME DATA ----][][][]

  // Future<void>PopularListApi() async{
  //
  //   isLoad = true;
  //   setState(() {
  //
  //   });
  //   var res = await http.get(( Uri.https(apiIp.ipAddress, '/glossary/api/popular')),
  //
  //      );
  //
  //   var popularlistJson = await jsonDecode(res.body);
  //   popularData =  PopularListModel.fromJson(popularlistJson);
  //   print("popularlistJson");
  //   print(popularlistJson);
  //   var x= await ValueStore().secureReadData("FCMtoken");
  //   print( x.toString()+ " mY toKEn");
  //
  //
  //
  //    isLoad = false;
  //   setState(() {
  //
  //
  //   });
  // }
  // void CategoriesApi() async{
  //
  //
  //   isLoad = true;
  //   setState(() {
  //
  //   });
  //
  //   var res = await http.get(( Uri.https(apiIp.ipAddress, '/glossary/api/categories')),
  //      );
  //
  //   var CategoriestJson = await jsonDecode(res.body);
  //
  //   print(CategoriestJson);
  // if(CategoriestJson['success']==true){
  //   categoriesData = CategoriesModel.fromJson(CategoriestJson);
  //  AppSettingsApi();
  // }
  //   // isLoad = false;
  //   setState(() {
  //
  //
  //   });
  // }
  // void AppSettingsApi()async{
  //   isLoad=true;
  //   setState(() {
  //
  //   });
  //
  //   var res = await http.get(Uri.https(apiIp.ipAddress, '/glossary/api/app_settings'));
  //   var SettingsJson = jsonDecode(res.body);
  //   print(SettingsJson);
  //
  //   if(SettingsJson['success']==true){
  //     settingsData = SettingsModel.fromJson(SettingsJson);
  //     currencySymbol= settingsData.data!.appsettining!.currencySymbol.toString();
  //     PopularListApi2();
  //   }
  //
  // }



  void CategoriesApi() async{
    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
       jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.categoriesData,
          context: context,
          callType: 'get',
          // bodyParameter: {
          //   "user_id": await ValueStore().secureReadData("currentUser") == null
          //       ? ""
          //       : await ValueStore().secureReadData("currentUser"),
          // }
           );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        AppSettingsApi();
        categoriesData = CategoriesModel.fromJson(jsonData);

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.categoriesData,
        context: context,
        callType: 'get',
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');


      if (jsonData['code'] == 200) {
        categoriesData = CategoriesModel.fromJson(jsonData);
        AppSettingsApi();

        if (mounted) setState(() {});
      }
    }
  }
  void PopularListApi() async{
    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.popularList,
        context: context,
        callType: 'get',
        // bodyParameter: {
        //   "user_id": await ValueStore().secureReadData("currentUser") == null
        //       ? ""
        //       : await ValueStore().secureReadData("currentUser"),
        // }
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        popularData = PopularListModel.fromJson(jsonData);
        var x= await ValueStore().secureReadData("FCMtoken");
        print( x.toString()+ " mY toKEn");



        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.categoriesData,
        context: context,
        callType: 'get',
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');


      if (jsonData['code'] == 200) {

        popularData = PopularListModel.fromJson(jsonData);
        if (mounted) setState(() {});
      }
    }
  }
  void AppSettingsApi() async{
    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.settingList,
        context: context,
        callType: 'get',
        // bodyParameter: {
        //   "user_id": await ValueStore().secureReadData("currentUser") == null
        //       ? ""
        //       : await ValueStore().secureReadData("currentUser"),
        // }
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        settingsData = SettingsModel.fromJson(jsonData);
        currencySymbol= settingsData.data!.appsettining!.currencySymbol.toString();
        PopularListApi();



        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.settingList,
        context: context,
        callType: 'get',
      );

      print(jsonData);
      categoriesData = CategoriesModel.fromJson(jsonData);
      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');


      if (jsonData['code'] == 200) {
        settingsData = SettingsModel.fromJson(jsonData);
        currencySymbol= settingsData.data!.appsettining!.currencySymbol.toString();
        PopularListApi();


        if (mounted) setState(() {});
      }
    }
  }





  
  pickUpOption(  {required List<Products> products, required int index , }){
   
    
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
                      itemCount: products[index].productPrice!.length,
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


                                      popularData!.data!.products![index].selectedPrice = popularData!.data!.products![index].productPrice![index2];
                                      setState(() {

                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        myText(title:products[index].productPrice![index2].unitValue.toString()+" "+products[index].productPrice![index2].unit.toString()
                                          , fontSize:18, fontWeight: FontWeight.w500, textColor: appColors.textBrown2,),
                                        myText(title: currencySymbol.toString()+products[index].productPrice![index2].productPrice.toString(), textColor: appColors.appOrange,fontSize: 20,fontWeight: FontWeight.w700,),
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






