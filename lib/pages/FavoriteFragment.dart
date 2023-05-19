import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/ExploreFragment.dart';
import 'package:groccery_store_2_2/pages/ItemDescription.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import '../Models/FavListModel.dart';
import 'SignUp1.dart';


class FavoriteFragment extends StatefulWidget {
  const FavoriteFragment({Key? key}) : super(key: key);

  @override
  State<FavoriteFragment> createState() => _FavoriteFragmentState();
}

class _FavoriteFragmentState extends State<FavoriteFragment> {

  final RoundedLoadingButtonController btnControllerShoping = new RoundedLoadingButtonController();
  FavListModel? favListData;
  GetStorage _getStorage = GetStorage();
 bool loading = true;



  @override
  void initState() {
    // TODO: implement initState
    var UserId = _getStorage.read("userID");
    FavoriteListApi();
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
        title:  myText(title: "Favorites", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body: loading==true?Center(child: CircularProgressIndicator(color: appColors.appOrange,)): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:favListData!.data!.favorite!.isEmpty?
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            //main list column

            Column(
              children: [
                //  image
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset('images/favourite.png' , height: 210,),
                ),
                SizedBox(height: 20),
                //  text header
                myText(title: "Your Heart Is Empty", textColor: appColors.textBrown2,fontSize: 20,fontWeight: FontWeight.w700,),
                SizedBox(height: 16),
                // main text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: myText(title: "Start fall in love with some good goods .",
                      textColor: appColors.textBrown2,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.center),
                ),
                SizedBox(height: 40),

                //  start shopping button
                RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  controller: btnControllerShoping,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExploreFragment(),));
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
        ):
        SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 55),
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
              //       padding: const EdgeInsets.only(left: 82.0),
              //       child: myText(title: "Favorite", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
              //     ),
              //   ],
              // ),
              SizedBox(height: 15),
              // grid items
              GridView.builder(

                // shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 6,
                    mainAxisExtent: 260,
                    childAspectRatio: 10),
                itemCount:favListData!.data!.favorite!.length,
                itemBuilder: (context, index) {
                  return productView(position:index);
                },
              ),


              //main list column
            ],
          ),
        ),
      )

    );
  }

  void FavoriteListApi() async{

    loading =true;
    setState(() {

    });

    final queryParameters = {
      "user_id": await ValueStore().secureReadData("currentUser")
    };

    var response = await http.post(Uri.https(apiIp.ipAddress , "/glossary/api/favorite" , queryParameters));

    var FavlistJson = jsonDecode(response.body);
    print("favourite Data\n");
    print(FavlistJson);

      favListData =   FavListModel.fromJson(FavlistJson);
      loading=false;
      setState(() {

      });



  }

  Widget productView({ required int position}) {
    return  Container(
      // height: 185,
      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
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
            favListData!.data!.favorite![position].productprice!.isNotEmpty &&  favListData!.data!.favorite![position].productprice!.first.unitValue!=null?
            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription(product_id: favListData!.data!.favorite![position].productId.toString()),)):null;
            // store.write("selProId", products[position].productId);
          },
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              SizedBox(
                  height:  MediaQuery.of(context).size.width/3.7,
                  width: MediaQuery.of(context).size.width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: favListData!.data!.favorite![position].imageUrl.toString(),
                    placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                    errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                  )),

              Padding(
                padding: const EdgeInsets.only(left: 10.0 , right: 10 , top: 0 , bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width/12,
                              width: MediaQuery.of(context).size.width/2.7,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: myText(title: favListData!.data!.favorite![position].productName, textColor: appColors.textBrown2,fontSize: 17,fontWeight: FontWeight.w700,))),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width/2.55,
                            height: MediaQuery.of(context).size.width/14,
                            decoration: BoxDecoration(
                                color: appColors.backgroundWhite,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 1 ,color: appColors.appOrange)
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                // openBottomSheet();
                              },
                              padding: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    myText(title: favListData!.data!.favorite![position].productprice![0].unitValue.toString()+" "+favListData!.data!.favorite![position].productprice![0].unit.toString(),
                                      textColor: appColors.darkGrey,fontSize: 12,fontWeight: FontWeight.w400,),
                                    Icon(Icons.arrow_drop_down, size: 15,color: appColors.appOrange,)

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/2.55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                myText(title:
                            favListData!.data!.favorite![position].productprice!.isNotEmpty?
                                "\$ "+ favListData!.data!.favorite![position].productprice!.first.productPrice.toString():"N/A",
                                  textColor: appColors.appOrange,fontSize: 20,fontWeight: FontWeight.w700,),

                                Icon(Icons.add_circle, size: 30,color: appColors.bgreen,)
                              ],
                            ),
                          ),

                        ],
                      ),
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


}
