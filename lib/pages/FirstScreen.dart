import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/pages/SignIn.dart';
import 'package:motion_toast/motion_toast.dart';


import '../components/CheckedCalls.dart';
import 'HomePage.dart';



class launchScreen extends StatefulWidget {
  const launchScreen({Key? key}) : super(key: key);

  @override
  State<launchScreen> createState() => _launchScreenState();
}

class _launchScreenState extends State<launchScreen> {
  bool anim=true;


  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),() =>   checkLog(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: appColors.backgroundWhite,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: appColors.backgroundWhite,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: appColors.backgroundWhite,
      body: Center(
       child: CircularProgressIndicator(color: appColors.appOrange),
      ),
    );
  }

  void checkLog() async{

    if( await checkCall().checkLogin()){
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  HomePage( tabPos: 0,)),(route) => false,);
    }
   else{
      await checkCall().checkSkipped()?
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>  HomePage( tabPos: 0,)),(route) => false,):
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) =>SignIn(refScreen: 'initial',)),(route) => false,);
    }

  }



}