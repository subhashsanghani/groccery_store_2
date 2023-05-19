import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/main.dart';
import 'package:groccery_store_2_2/pages/ItemDescription.dart';
import 'package:http/http.dart' as http;
import '../Components/ColorsFile.dart';
import '../Models/SearchModel.dart';
import '../components/valueStore.dart';



class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   SearchModel? searchData ;
  bool Loaded = false;
  GetStorage storage = GetStorage();
  bool apiCalled = true;
  TextEditingController _controller= TextEditingController();
   ProductPrices selectedSize = ProductPrices();


  @override
  void initState() {

    setState(() {
      searchApi("am");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16),
          child: Column(
            children: [

              SizedBox(height: 70,),
              Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: appColors.backgroundWhite,
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
                          child: Icon(Icons.search_rounded, color: appColors.textBrown257,)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(

                        controller: _controller,
                        onChanged: (value) {
                          if(_controller.text.isEmpty || value.isEmpty){

                            setState(() {
                              apiCalled=true;
                              searchData!.data!.search!.clear();
                            });
                          }else {
                             searchApi(value);
                          }
                        },
                        cursorColor: appColors.appOrange,
                        decoration: InputDecoration(
                            focusColor: appColors.appOrange,
                            iconColor: appColors.appOrange,
                            fillColor: appColors.appOrange,
                            hoverColor: appColors.appOrange,
                            prefixIconColor: appColors.appOrange,
                            suffixIconColor: appColors.appOrange,
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(

                                color: appColors.textBrown257,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),




              apiCalled? Center(child: myText(title: "Search Anything Here",)):
              GridView.builder(

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 240,
                    childAspectRatio: 10),
                itemCount: int.parse(searchData!.data!.search!.length.toString()),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(left:2 ,right: 2, top: 0 ,bottom: 10),
                    child: Container(
                      // height: 185,
                      width: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: appColors.backgroundWhite,
                          boxShadow: [BoxShadow(color: appColors.shadow, spreadRadius: 1 , blurRadius: 2)]

                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription(product_id: searchData!.data!.search![index].productId.toString()),));
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
                                      imageUrl: searchData!.data!.search![index].imageUrl.toString(),
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
                                              height: MediaQuery.of(context).size.width/12,
                                              width: MediaQuery.of(context).size.width/2.8,
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: myText(title: searchData!.data!.search![index].productName,
                                                  textColor: appColors.textBrown2,fontSize: 16,fontWeight: FontWeight.w700,maxLines: 3, textAlign: TextAlign.start,),
                                              )),
                                          SizedBox(height: 8,),
                                          Container(
                                            width: MediaQuery.of(context).size.width/2.7,
                                            height: MediaQuery.of(context).size.width/14,
                                            decoration: BoxDecoration(
                                                color: appColors.backgroundWhite,
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 1 ,color: appColors.appOrange)
                                            ),
                                            child: MaterialButton(
                                              onPressed: (){
                                                openBottomSheet(index:index, products: searchData!.data!.search!);
                                               // Navigator.push(context, MaterialPageRoute(builder: (context) => ItemDescription(product_id: searchData!.data!.search![index].productId.toString()),));
                                              },
                                              padding: EdgeInsets.zero,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    myText(title: searchData!.data!.search![index].selectedPrice!=null?searchData!.data!.search![index].selectedPrice!.unitValue.toString()+" "+searchData!.data!.search![index].selectedPrice!.unit.toString():
                                                    searchData!.data!.search![index].productPrices!.first.unitValue.toString()+" "+searchData!.data!.search![index].productPrices!.first.unit.toString() ,
                                                      textColor: appColors.darkGrey,fontSize: 12,fontWeight: FontWeight.w400,),
                                                    Icon(Icons.arrow_drop_down, size: 15,color: appColors.appOrange,)

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width/2.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                myText(title:searchData!.data!.search![index].selectedPrice!=null?searchData!.data!.search![index].selectedPrice!.productPrice.toString():
                                                searchData!.data!.search![index].productPrices!.isNotEmpty?
                                                currencySymbol+" "+  searchData!.data!.search![index].productPrices![0].productPrice.toString(): "N/A", textColor: appColors.appOrange,fontSize: 18,fontWeight: FontWeight.w600,),
                                                SizedBox(width: 42,),
                                                Icon(Icons.add_circle, size: 30,color: appColors.bgreen,)
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
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

    );
  }

   void openBottomSheet({required int index, required List<Search> products}) {

     showModalBottomSheet<dynamic>(

       enableDrag: true,
       backgroundColor: Colors.transparent,
       context: context, builder: (context) => pickUpOption(products:products , index:index),);
   }

   pickUpOption(  {required List<Search> products, required int index , }){


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


                                       searchData!.data!.search![index].selectedPrice = searchData!.data!.search![index].productPrices![index2];
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


  void searchApi(String value) async {

    Loaded=true;

    var search =await http.post(Uri.http(apiIp.ipAddress , "/glossary/api/search"),
    body: {
      "product_name": value
        }
    );

    var searchResponse = await search.body.toString();
    var searchJson = await jsonDecode(searchResponse);
    print(searchJson);
    searchData =SearchModel.fromJson(searchJson);
    Loaded=false;
    setState(() {
      apiCalled=false;
    });

  }
}
