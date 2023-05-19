import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Models/SocietyModel.dart';
import 'package:http/http.dart' as http;

class SocietyPage extends StatefulWidget {
  const SocietyPage({Key? key}) : super(key: key);

  @override
  State<SocietyPage> createState() => _SocietyPageState();
}

class _SocietyPageState extends State<SocietyPage> {

  TextEditingController controller = TextEditingController();

  SocietyModel? SocietyData ;
  bool Loaded = false;
  bool apiCalled = true;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      SocietyApi("");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appColors.backgroundWhite,
      body: Loaded?Center(child: CircularProgressIndicator(color: appColors.appOrange, backgroundColor: appColors.lightOrange,)):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 70,),
              //search bar
              Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: appColors.borderGrey,
                  border: Border.all(color: appColors.borderGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        minWidth: 35,
                        height: 35,
                        padding: EdgeInsets.zero,
                        onPressed: (){

                        },
                        child: Container(
                          padding: EdgeInsets.all(7),
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35)
                          ),
                          child: Icon(Icons.search , color: appColors.textBrown2,),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(

                        controller: controller,

                        onChanged: (value) {
                          if (controller.text.isEmpty ) {
                            setState(() {
                              SocietyData!.data!.society!.clear();
                              SocietyApi(value);
                            });
                          } else {
                            SocietyApi(value);

                          }
                        },

                        cursorColor: appColors.appOrange,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Society",
                            hintStyle: TextStyle(

                                color: appColors.hint,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              //  search list
             ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:SocietyData!.data!.society!.length,
                itemBuilder: (context, index) {
                  return   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: appColors.lightOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                        child: MaterialButton(
                          onPressed: (){

                            var selectedSoc={
                              "socName": SocietyData!.data!.society![index].socityName,
                              "socId": SocietyData!.data!.society![index].socityId,
                            };
                            Navigator.pop(context , selectedSoc);
                          },
                          child: Column(
                            children: [
                              // soc. name and pin code row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(title: SocietyData!.data!.society![index].socityName.toString(), textColor: appColors.textBrown2,fontSize: 20,fontWeight: FontWeight.w700,),
                                  myText(title:"Pincode : " +SocietyData!.data!.society![index].pincode.toString(), textColor: appColors.textBrown2,fontSize: 16,fontWeight: FontWeight.w400,),
                                ],
                              ),
                              //delivery charge
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  myText(title:"Delivery Charge : ", textColor: appColors.textBrown2,fontSize: 14,fontWeight: FontWeight.w400,),
                                  myText(title: SocietyData!.data!.society![index].deliveryCharge.toString() + ".Rs", textColor: appColors.appOrange,fontSize: 14,fontWeight: FontWeight.w600,),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }

  void SocietyApi(String value) async {
    Loaded=true;

    var res = await http.get(( Uri.https(apiIp.ipAddress, '/glossary/api/society')));



    var listJson = await jsonDecode(res.body);
    SocietyData =SocietyModel.fromJson(listJson);

    print(listJson);
    Loaded = false;
    setState(() {
      apiCalled=false;
    });

  }
}
