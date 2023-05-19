import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/pages/CategoriesItems.dart';
import 'package:groccery_store_2_2/pages/SearchScreen.dart';
import 'package:http/http.dart' as http;
import '../Components/ColorsFile.dart';
import '../Models/CategoriesModel.dart';

class ExploreFragment extends StatefulWidget {
  const ExploreFragment({Key? key}) : super(key: key);

  @override
  State<ExploreFragment> createState() => _ExploreFragmentState();
}

class _ExploreFragmentState extends State<ExploreFragment> {

  CategoriesModel? categoriesData;
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    CategoriesApi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad==true? Center(child: CircularProgressIndicator(color: appColors.appOrange,)):SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 55,),
            //Search and filter bar
            myText(title: "Categories", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            SizedBox(height: 18,),
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
            SizedBox(height: 30,),
          //  categories grid
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 5,
                  mainAxisExtent: 150,
                  childAspectRatio: 10),
              itemCount: categoriesData!.data!.category!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                      padding: EdgeInsets.only(left: 5 ,right: 5),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesItems(subCatList:categoriesData!.data!.category![index].subCat!),));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  border: Border.all(color: appColors.appOrange)
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: categoriesData!.data!. category![index].imageUrl.toString(),
                                      placeholder: (context, url) => Image.asset('images/placeBasket.png'),
                                      errorWidget: (context, url, error) => Image.asset('images/placeBasket.png'),

                                    ))),
                          ),

                          myText(title: categoriesData!.data!.category![index].title,fontSize: 15,fontWeight: FontWeight.w400,textColor: appColors.textBrown2,)


                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void CategoriesApi() async{

    isLoad = true;
    var res = await http.get(( Uri.https(apiIp.ipAddress, '/glossary/api/categories')),

    );

    var CategoriestJson = await jsonDecode(res.body);
    categoriesData =CategoriesModel.fromJson(CategoriestJson);
    print(CategoriestJson);
    setState(() {
      isLoad = false;

    });
  }

}
