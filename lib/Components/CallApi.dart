import 'dart:convert';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';


import 'package:groccery_store_2_2/Components/urlData.dart';
import 'package:groccery_store_2_2/pages/ServerIssuePage.dart';
import 'package:groccery_store_2_2/pages/noInternetScreen.dart';

import 'package:motion_toast/motion_toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_loader_overlay/progress_loader_overlay.dart';


class CallApi {
  //default header without access
  var headerFile = {
    "x-api-key": UrlData.apiKey,
  };

  //most of api is calls using this function for api call
  //below method will return json
  sendApiRequest(
      {required String url,
      Map<String, dynamic>? bodyParameter,
      required BuildContext context,
      required String callType,
      required bool showLoader,
      required bool visibleLoad,
      String? tokenVal}) async {
    print("Api Called:$url");
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => noInternetScreen(),
          ),
          (route) => false);
      //net not connected code run view here
      // showDialog(context: context, builder: (context) =>  noConnectionAvailable(),);
    } else {
      // showLoader ? Loader.show(context) : null;

      switch (callType) {
        case 'post':
          {
            print(
                "__________Using POST Request Api Called=> url:${UrlData.api_url}$url & parameters Passed $bodyParameter ___________");
            final ConnectivityResult result =
                await Connectivity().checkConnectivity();
            if (result == ConnectivityResult.none) {
              MotionToast.warning(description: "Check Your Connection").show(context);
            } else {
              ProgressLoader().widgetBuilder = (context, _) => visibleLoad
                  ? Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: appColors.appOrange,
                        backgroundColor: Colors.orangeAccent,
                      )),
                    )
                  : Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Container(
                        color: Colors.white,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: appColors.appOrange,
                          backgroundColor: Colors.orangeAccent,
                        )),
                      ),
                  );
              showLoader ? await ProgressLoader().show(context) : null;
              try {
                var response = await http.post(
                  Uri.parse(UrlData.api_url + url),
                  headers: headerFile,
                  body: bodyParameter,
                );
                if (response.statusCode == 200) {
                  var myjson = jsonDecode(response.body);
                  await ProgressLoader().dismiss();
                  return myjson;
                } else {
                  //here server issuee page set
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConnectionIssuePage(response.statusCode),
                      ));
                }
              } catch (e) {
                await ProgressLoader().dismiss();
                MotionToast.warning(description: e.toString()).show(context);
              }
            }
          }
          break;
        case 'get':
          {
            print(
                "_________Using GET Request Api Called=> url: ${UrlData.api_url}$url ___________");
            final ConnectivityResult result =
                await Connectivity().checkConnectivity();
            if (result == ConnectivityResult.none) {
              MotionToast.warning(description: "Check Your Connection")
                  .show(context);
            } else {
              ProgressLoader().widgetBuilder = (context, _) => visibleLoad
                  ? Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: appColors.appOrange,
                        backgroundColor: Colors.orangeAccent,
                      )),
                    )
                  : Container(
                      color: Colors.white,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: appColors.appOrange,
                        backgroundColor: Colors.orangeAccent,
                      )),
                    );
              showLoader ? await ProgressLoader().show(context) : null;
              var params = {
                "token": tokenVal,
              };

              try {
                var response = await http.get(
                  Uri.parse(UrlData.api_url + url),
                  headers: headerFile,
                );
                // var response = await http.get(Uri.https(UrlData.api_url, url,
                //     tokenVal!=""?
                //     params:null),
                //   headers: headerFile,
                // );
                if (response.statusCode == 200) {
                  var myjson = jsonDecode(response.body);
                  await ProgressLoader().dismiss();

                  return myjson;
                } else {
                  // return Navigator.pushReplacement(context, MaterialPageRoute(
                  //   builder: (context) => ConnectionIssuePage(response.statusCode),));
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConnectionIssuePage(response.statusCode),
                      ));
                }
              } catch (e) {
                MotionToast.warning(description: e.toString()).show(context);
                await ProgressLoader().dismiss();
              }
            }
          }
          break;
      }
    }
  }

//ending of apiCalls class
}
