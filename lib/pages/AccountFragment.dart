import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/OrdersPage.dart';
import 'package:groccery_store_2_2/components/CheckedCalls.dart';
import 'package:groccery_store_2_2/pages/AddressesPage.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Components/ColorsFile.dart';
import 'ProfilePage.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {

  bool logCheck1 = false;
  RoundedLoadingButtonController _btnController =  RoundedLoadingButtonController();
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

  @override
  void initState() {
    // TODO: implement initState
    checkLog();
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

        title:  myText(title: "Account", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:isLoad==true?Center(child: CircularProgressIndicator(color: appColors.appOrange,)):
      logCheck1==true? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 55),
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
            //       padding: const EdgeInsets.only(left: 78.0),
            //       child: myText(title: "Account", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 50),
            //  profile button Row
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/Icons/profile.png" , height: 24 , width: 24,),
                    SizedBox(width: 20,),
                    myText(title: "Profile", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                  ],
                ),
              ),
            ),

            Divider(height: 25,thickness: 1, color: appColors.brownshadow01,),
            // orders button row
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage(),));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/Icons/order.png" , height: 24 , width: 24,),
                    SizedBox(width: 20,),
                    myText(title: "Orders", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                  ],
                ),
              ),
            ),

            Divider(height: 25,thickness: 1, color: appColors.brownshadow01,),
            //address button row
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddressesPage(refScreen:"addressList"),));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/Icons/address.png" , height: 24 , width: 24,),
                    SizedBox(width: 20,),
                    myText(title: "Address", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                  ],
                ),
              ),
            ),

            Divider(height: 25,thickness: 1, color: appColors.brownshadow01,),

            // Divider(height: 30,thickness: 1, color: appColors.brownshadow01,),
          ],
        ),
      ):
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "images/loginWarning.png",
                width: MediaQuery.of(context).size.height / 2.5,
              ),
              SizedBox(
                height: 50,
              ),
              myText(
                title:
                "Login to app to enjoy order and access profile",
                fontWeight: FontWeight.w500,
                textColor: appColors.textBrown2,
                fontSize: 22,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              RoundedLoadingButton(
                controller: _btnController,
                errorColor: appColors.appOrange,
                color: appColors.appOrange,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(refScreen: "acc"),
                      ));
                  Future.delayed(Duration(seconds: 1),
                          () => _btnController.stop());
                },
                child: Container(
                  height:
                  MediaQuery.of(context).size.width / 6.25,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: appColors.appOrange,
                      borderRadius: BorderRadius.circular(30)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Align(
                      alignment: Alignment.center,
                      child: myText(
                        title: "Login",
                        textColor: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
