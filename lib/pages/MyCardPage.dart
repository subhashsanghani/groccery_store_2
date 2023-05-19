import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';

import 'NewCardPage.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({Key? key}) : super(key: key);

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 55),
              // main app bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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

                              },
                              child: Center(child: Icon(Icons.arrow_back_ios,
                                color: appColors.appOrange, size: 18,))),
                        ),
                      ),
                    ),
                  ),
                  // my cards
                  myText(title: "My Cards", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                //  plus button
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCard(),));
                              },
                              child: Center(child: Icon(Icons.add,
                                color: appColors.appOrange, size: 22,))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),

            // Cards list
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:8,
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // card image , name , and number row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // card image
                                  SizedBox(height: 40, width: 60, child: Image.asset("images/Icons/mastercard.png" ,)),

                                  SizedBox(width: 10,),
                                  // card name and number
                                  SizedBox(
                                    height: 45,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // name
                                        myText(title: "My Card", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                                        SizedBox(height: 10,),
                                        myText(title: "5342 **** **** 6745", textColor: appColors.textBrown2,fontSize: 12,fontWeight: FontWeight.w400,),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // swipe to delete and forward button
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: appColors.textBrown2,),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios, size: 12, color: appColors.textBrown257,),
                                      myText(title: "Swipe to delete  ", textColor: appColors.textBrown257,fontSize: 10,fontWeight: FontWeight.w400,),
                                    ],
                                  ),
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
    );
  }
}
