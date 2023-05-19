import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CallApi.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Components/urlEndPoint.dart';
import 'package:groccery_store_2_2/Models/AddressModel.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/NewAddressesPage.dart';
import 'package:groccery_store_2_2/pages/UpdateAddress.dart';
import 'package:http/http.dart' as http;



class AddressesPage extends StatefulWidget {
  String? refScreen;
   AddressesPage({Key? key, this.refScreen}) : super(key: key);

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {

  GetStorage _storeBox = new GetStorage();
  AddressListModel? AddressData ;
  bool Loaded = true;
  var jsonData;


  @override
  void initState() {
    // TODO: implement initState

    AddressListApi2();
    print(_storeBox.read("userId"));


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
            margin: EdgeInsets.only(left: 20 , top: 10),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ),
        actions: [
          //  plus button
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40,
                width: 30,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddressesPage() ));
                      },
                      child: Center(child: Icon(Icons.add,
                        color: appColors.appOrange, size: 22,))),
                ),
              ),
            ),
          ),
        ],
        title:  myText(title: "Addresses", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:Loaded ? Center(child: CircularProgressIndicator(color: appColors.appOrange, backgroundColor: appColors.lightOrange,)):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // SizedBox(height: 55),
              // main app bar
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     // back button
              //     Padding(
              //       padding: const EdgeInsets.only(left: 8.0),
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 40,
              //           width: 30,
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
              //     // my cards
              //     myText(title: "Addresses", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
              //     //  plus button
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8.0),
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 40,
              //           width: 30,
              //
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(40),
              //             child: MaterialButton(
              //                 padding: EdgeInsets.zero,
              //                 onPressed: () {
              //
              //                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddressesPage() ));
              //                 },
              //                 child: Center(child: Icon(Icons.add,
              //                   color: appColors.appOrange, size: 22,))),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 5),

              // Cards list
             AddressData!.data!.userlocation==null?Padding(
               padding: const EdgeInsets.only(top: 270),
               child: Center(child: myText(title: "Please Add New Address !!", textColor: appColors.textBrown257, fontSize: 16,)),
             ): ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:AddressData!.data!.userlocation!.length,
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
                                DeleteAddressApi(AddressData!.data!.userlocation![index].locationId.toString());
                                AddressListApi2();
                                setState(() {

                                });
                              },
                              backgroundColor: appColors.maroon,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,

                            )
                          ],
                        ),
                        // main box
                        child: SizedBox(

                          child: MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: (){
                              var a= {
                                // AddressData!.data!.userlocation![index].
                              };
                              widget.refScreen=="selectAddress"? Navigator.pop(context ,  AddressData!.data!.userlocation![index]):
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAddress(),));
                              _storeBox.write("userName", AddressData!.data!.userlocation![index].receiverName);
                              _storeBox.write("userPhone", AddressData!.data!.userlocation![index].receiverMobile);
                              _storeBox.write("userPincode", AddressData!.data!.userlocation![index].pincode);
                              _storeBox.write("userHouse", AddressData!.data!.userlocation![index].houseNo);
                              _storeBox.write("userSocietyId", AddressData!.data!.userlocation![index].socityId);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // card image , name , and number row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // card image
                                    SizedBox(height: 25, width: 25, child: Image.asset("images/Icons/ghar.png" ,)),

                                    SizedBox(width: 20,),
                                    // card name and number
                                    SizedBox(

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25,),
                                          // name
                                          SizedBox(
                                              width: MediaQuery.of(context).size.width/2.0,
                                              child: myText(title:AddressData!.data!.userlocation![index].receiverName,
                                                textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,maxLines: 2,)),
                                          SizedBox(height: 7,),
                                          SizedBox(
                                              child: myText(title:AddressData!.data!.userlocation![index].houseNo , textColor: appColors.textBrown2,fontSize: 14,fontWeight: FontWeight.w400,)),
                                          SizedBox(height: 7,),
                                          myText(title:AddressData!.data!.userlocation![index].pincode.toString(), textColor: appColors.textBrown2,fontSize: 12,fontWeight: FontWeight.w400,),
                                          SizedBox(height: 20,),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // swipe to delete and forward button
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Icon(Icons.arrow_forward_ios_sharp, size: 18, color: appColors.textBrown2,),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [
                                        Icon(Icons.arrow_back_ios, size: 12, color: appColors.textBrown257,),
                                        SizedBox(height: 10,),
                                        myText(title: "Swipe to delete  ", textColor: appColors.textBrown257,fontSize: 10,fontWeight: FontWeight.w400,),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
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
            ],
          ),
        ),
      ),
    );
  }

   // void AddressListApi() async{
   //   Loaded=true;
   //   setState(() {
   //
   //   });
   //
   //   var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/getaddress')),
   //
   //       body: {
   //         "user_id": await ValueStore().secureReadData("currentUser")
   //         // _storeBox.read("userId").toString()
   //         // 'user_id':await ValueStore().secureReadData("currentUser") ,
   //       });
   //
   //   var listJson = await jsonDecode(res.body);
   //   AddressData = await AddressListModel. fromJson(listJson);
   //
   //   print(listJson);
   //   Loaded = false;
   //   setState(() {
   //
   //   });
   // }

  void AddressListApi2() async{
    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
       jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.addressList,
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

        AddressData = AddressListModel.fromJson(jsonData);
        Loaded=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.addressList,
        context: context,
        callType: 'get',
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');


      if (jsonData['code'] == 200) {
        AddressData = AddressListModel.fromJson(jsonData);
        Loaded=false;

        if (mounted) setState(() {});
      }
    }
  }

  // void DeleteAddressApi(String? LocationId) async{
  //   Loaded=true;
  //
  //   var res = await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/deleteaddress')),
  //
  //       body: {
  //         "location_id": LocationId
  //         // 'user_id':await ValueStore().secureReadData("currentUser") ,
  //       });
  //
  //   var deleteJson = await jsonDecode(res.body);
  //
  //   print(deleteJson);
  //   Loaded = false;
  //   setState(() {
  //
  //   });
  // }


  void DeleteAddressApi(String? LocationId) async{

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
      jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.deleteAddress,
          context: context,
          callType: 'post',
          bodyParameter: {

            "user_id": await ValueStore().secureReadData("currentUser") == null
                ? ""
                : await ValueStore().secureReadData("currentUser"),
            "location_id": LocationId
          }
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);

        Loaded=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.deleteAddress,
        context: context,
        callType: 'get',
      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }
}
