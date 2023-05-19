

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';


class ConnectionIssuePage extends StatefulWidget {
  int statusCode;
  ConnectionIssuePage(this. statusCode, {Key? key}) : super(key: key);

  @override
  State<ConnectionIssuePage> createState() => _ConnectionIssuePageState();
}

class _ConnectionIssuePageState extends State<ConnectionIssuePage> {
  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.backgroundWhite,
          elevation: 0,
          leading: MaterialButton(
              onPressed: () =>SystemNavigator.pop(),
              minWidth: 25,
              height: 25,
              padding: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Icon(Icons.arrow_back_ios , color: appColors.appOrange,)),
        ),
        backgroundColor: appColors.backgroundWhite,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Center(child: Image.asset("images/launch_logo.png",width: MediaQuery.of(context).size.width/2,)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset("images/loginWarning.png",width: MediaQuery.of(context).size.width/1.2,),
                    SizedBox(height: 30,),
                    myText(title:"OOPS ! NO RESPONSE !" , textColor: appColors.appOrange,fontSize: 22),
                    myText(title: getIssueName(widget.statusCode),),
                    SizedBox(height: 90,),

                  ],
                ),
              ),
              myText(title: "Error Code: ${widget.statusCode}",),
              SizedBox(height: 50,)

            ],
          ),
        ),
      ),
    );
  }

  String getIssueName(int statusCode){
    switch(statusCode){
      case 400:return "Bad Request";
      case 401:return "Unauthorised: ";
      case 403:return "Unauthorised: ";
      case 500:return "Can't Reach The Server: ";
      default: return "Server Is Under Maintenance";
    }
  }

}
