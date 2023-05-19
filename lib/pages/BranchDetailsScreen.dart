import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/CallApi.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Components/urlEndPoint.dart';
import 'package:groccery_store_2_2/Models/BranchListModel.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/PaymentDelivery.dart';
import 'package:http/http.dart' as http;

class BranchDetailsScreen extends StatefulWidget {
  String? total;
  bool? canpop;

   BranchDetailsScreen({Key? key,  this.total, this.canpop}) : super(key: key);

  @override
  State<BranchDetailsScreen> createState() => _BranchDetailsScreenState();
}

class _BranchDetailsScreenState extends State<BranchDetailsScreen> {

  bool Loaded = true;
  BranchListModel? branchListData;
  GetStorage storage2 = GetStorage();
  var jsonData;

  @override
  void initState() {
    // TODO: implement initState
    BranchListApi2();
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
        title:  myText(title: "Branches", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
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
              //
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
              //     SizedBox(width: 70),
              //     // Branches
              //     myText(title: "Branches", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
              //
              //   ],
              // ),
              SizedBox(height: 5),

              // Cards list
              branchListData!.data!.branches!.isEmpty?Padding(
                padding: const EdgeInsets.only(top: 270),
                child: myText(title: "Please Add New Address !!", textColor: appColors.textBrown257, fontSize: 16,),
              ): ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:branchListData!.data!.branches!.length,
                itemBuilder: (context, index) {
                  return   Column(
                    children: [
                      SizedBox(

                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            var a= {
                              // AddressData!.data!.userlocation![index].
                            };
                            storage2.write("branchName", branchListData!.data!.branches![index].name);
                            storage2.write("bra_add", branchListData!.data!.branches![index].address);
                            storage2.write("zipcode", branchListData!.data!.branches![index].pincode);
                            storage2.write("branch_id", branchListData!.data!.branches![index].id);
                            print(widget.total.toString()+"888888888");
                            if(widget.canpop==true){
                             Navigator.pop(context);
                            }else {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    PaymentDelivery(order_type_pickup: true,
                                        total: widget.total.toString()),));
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // card image , name , and number row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // card image
                                      SizedBox(height: 25, width: 25, child: Icon(Icons.work , color: Colors.brown,)),

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
                                                child: myText(title:branchListData!.data!.branches![index].name,
                                                  textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,maxLines: 2,)),
                                            SizedBox(height: 7,),
                                            SizedBox(
                                                child: myText(title:branchListData!.data!.branches![index].address , textColor: appColors.textBrown2,fontSize: 14,fontWeight: FontWeight.w400,)),
                                            SizedBox(height: 7,),
                                            myText(title:branchListData!.data!.branches![index].pincode.toString(), textColor: appColors.textBrown2,fontSize: 12,fontWeight: FontWeight.w400,),
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

                                    ],
                                  ),


                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  myText(title: "Available Slots  : ", fontSize: 14, textColor: appColors.appOrange, ),
                                  myText(title: branchListData!.data!.branches![index].openingTime.toString() + "  to  " +branchListData!.data!.branches![index].closingTime.toString(), fontSize: 16 , textColor: appColors.bgreen, ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(child: Divider(height: 5 ,thickness: 1,color: appColors.brownshadow01,))
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
  
  // BranchListApi() async{
  //   Loaded = true;
  //   setState(() {
  //
  //   });
  //   var brares = await http.get(Uri.https(apiIp.ipAddress, "/glossary/api/branches"));
  //
  //
  //   var branchJson = jsonDecode(brares.body);
  //   print(branchJson);
  //
  //   branchListData = BranchListModel.fromJson(branchJson);
  //   if(branchJson['success']){
  //     Loaded = false;
  //     setState(() {
  //
  //     });
  //   }
  //
  // }

  void BranchListApi2() async{

    var a = await checkCall().checkLogin();
    if (a) {

      // "if user login Api call"
       jsonData = await CallApi().sendApiRequest(
          visibleLoad: false,
          showLoader: true,
          url: EndPoint.branchList,
          context: context,
          callType: 'get',

      );

      print(jsonData);

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');

      if (jsonData['code'] == 200) {
        print(jsonData);
        branchListData = BranchListModel.fromJson(jsonData);

        Loaded=false;

        if (mounted) setState(() {});
      }
    }
    else {
      //  "no login Api call
      jsonData = await CallApi().sendApiRequest(
        visibleLoad: false,
        showLoader: true,
        url: EndPoint.branchList,
        context: context,
        callType: 'get',
      );

      print(jsonData);
      if (jsonData['code'] == 200) {
        print(jsonData);


        Loaded=false;

        if (mounted) setState(() {});
      }

      // _currentCat=int.parse(_homeData!.data!.categories!.first.categoryId!.isNotEmpty?_homeData!.data!.categories!.first.categoryId.toString():'1');



    }
  }
}
