import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/CartFragment.dart';
import 'package:groccery_store_2_2/pages/ExploreFragment.dart';
import 'package:groccery_store_2_2/pages/HomeFragment.dart';
import 'package:groccery_store_2_2/pages/MainScreen.dart';
import 'package:groccery_store_2_2/pages/OrderDetailsScreen.dart';

import 'AccountFragment.dart';
import 'FavoriteFragment.dart';

class HomePage extends StatefulWidget {
  int tabPos;
  HomePage({Key? key, required this.tabPos}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState(tabPos);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  var padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
  double gap= 5;
  late TabController tabController;
  int currentindex = 0;
  GetStorage mystorage = GetStorage();
  bool logCheck1 = false;

  bool isLoad =false;

  void checkLog() async  {
    isLoad= true;
    setState(() {

    });
    logCheck1 = await checkCall().checkLogin();
    var s= await ValueStore().secureReadData("isLoggedIn");
    if(s=="yes"){
      logCheck1=true;

    }else
    {
      logCheck1=false;
    }
    isLoad =false;
    setState(() {

    });


  }




  int tabPos;
  _HomePageState(this.tabPos);


  @override
  void initState() {
    checkLog();
    super.initState();
    // ValueStore().secureReadData("isLoggedIn").then((v){
    //   if(v=='yes'){
    //     logCheck1=true;
    //     setState(() {
    //
    //     });
    //   }
    // });
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    tabController.index=tabPos;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // body: pages[tabPos!=0?tabPos:currentindex],
      body:isLoad==false? TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children:[
            HomeFragment(),
            ExploreFragment(),
            logCheck1==true? CartFragment():MainScreen(refScreen: "cart",),
            logCheck1==true? FavoriteFragment():MainScreen(refScreen:"fav"),
            // OrderDetailsScreen()
            logCheck1==true?AccountFragment():MainScreen(refScreen: "acc",),

          ]
      ):Center(child: CircularProgressIndicator(color: appColors.appOrange,)),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.width/4.5,
        decoration:  BoxDecoration(

          borderRadius: BorderRadius.circular(25),


        ),
        child: Container(
          decoration: BoxDecoration(
              color: appColors.backgroundWhite,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(13) , topRight: Radius.circular(13)),
              boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.06) , blurRadius: 10)]

          ),
          child: TabBar(

            physics: NeverScrollableScrollPhysics(),
            indicatorColor: appColors.appOrange,
            indicatorWeight: 5,
            labelStyle: TextStyle(fontWeight: FontWeight.w400 , fontSize: 9,color: appColors.textBrown2),

            indicator: BoxDecoration(
              color: appColors.appOrange,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
            ),
            indicatorSize: TabBarIndicatorSize.label,

            indicatorPadding: EdgeInsets.only(top: 0 ,bottom:  MediaQuery.of(context).size.width/4.7) ,
            labelColor:Colors.orange,
            unselectedLabelColor: appColors.textBrown2,
            onTap: (value) {
              setState(() {
                currentindex = value;
              });
            },
            controller: tabController,
            tabs: [
              Tab(icon:Image.asset("images/Icons/ghar.png" , height: 22,width: 18,color: tabController.index==0?appColors.appOrange:null,), text: "Shop",),
              Tab(icon:Image.asset("images/Icons/mglass.png" , height: 22,width: 18,color: tabController.index==1?appColors.appOrange:null,), text: "Explore",),
              Tab(icon:Image.asset("images/Icons/cart1.png" , height: 22,width: 18,color: tabController.index==2?appColors.appOrange:null,), text: "Cart",),
              Tab(icon:Image.asset("images/Icons/heart.png" , height: 22,width: 18,color: tabController.index==3?appColors.appOrange:null,), text: "Favorite",),
              Tab(icon:Image.asset("images/Icons/user.png" , height: 22,width: 18,color: tabController.index==4?appColors.appOrange:null,), text: "Account",),

            ],
          ),
        )
        ,
      ),

    );
  }
}
