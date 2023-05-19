
// import 'package:food_order/common/CommonScaffold.dart';
// import 'package:food_order/models/OrderModel.dart';
//
// import 'package:food_order/screens/payment/Body.dart';
// import 'package:food_order/screens/thanks/Thanks.dart';
//
// import 'package:food_order/components/CustomLoader.dart';
//
// import 'package:food_order/config/globals.dart' as globles;
//
// import 'package:food_order/utils/CallApi.dart';
// import 'package:food_order/utils/CommonUtils.dart';

import 'dart:convert';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/payment/Body.dart';

class Payment extends StatefulWidget {
  Payment({Key? key, required this.paymentUrl}) : super(key: key);

  final String paymentUrl;

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  InAppWebViewController? _controller;

  @override
  void initState() {
    super.initState();

    print('MyUrlCheck' + widget.paymentUrl.toString());
    WebViewImplementation.NATIVE;
    InAppWebViewOptions(
      cacheEnabled: false,
      clearCache: true,
    );
    /*SchedulerBinding.instance.addPostFrameCallback((_) {
      globles.isLoading = true;
      CallApi().showLoading(context);
    });*/
  }

  Future<bool> _onWillPop() async {
    if (await _controller?.canGoBack() ?? false) {
      _controller?.goBack();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        resizeToAvoidBottomInset: false,
        body: Body(
          url: widget.paymentUrl.toString(),
          controller: _controller,
          setWebController: (controller) => setState(() {
            _controller = controller;
          }),
          onLoadStart: () {
            print("start");
            // globles.isLoading = true;
            // CallApi().showLoading(context);
          },
          onLoadStop: () {
            print("stop");
            // globles.isLoading = false;
            // CallApi().showLoading(context);
          },
          onPaymentSuccess: (url) => _makeGetPaymentData(context, url),
        ),
      ),
    );
  }

  _makeGetPaymentData(BuildContext context, String url) async {
    // print("CHeckOutData");
    // var a=jsonEncode(myJsonData['data']).toString();
    // print(jsonDecode(a)['url']);

    print("Success :::::::::::::::::::::" + url.toString().substring(26));
     var resultJson =await http.post(( Uri.https(apiIp.ipAddress, '/glossary/api/sendorder')),body: {
       "user_id" : ValueStore().secureReadData("currentUser"),

     });

    // await CallApi().sendApiRequest(
    //     visibleLoad: false,
    //     showLoader: true,
    //     url: url.toString().substring(26),
    //     context: context,
    //     callType: 'get');
    // var a = jsonEncode(resultJson['data']).toString();
    // String finalUrl = jsonDecode(a)['url'].toString().replaceAll("\\", "");
    // String tkVal = jsonDecode(a)['token'].toString();
    // print("TokenVal/; " + tkVal);
    // _makeGetPaymentDataFinal(context,
    //     '/projects/restaurant/index.php/rest/order/successpayment', tkVal);

    // print(resultJson);

    // CallApi().get(context, url, true).then((response) {
    //   if (response != null && response.isNotEmpty) {
    //     Map jsonMap = json.decode(response);
    //     Map data = jsonMap["data"];
    //     String finalUrl = data["url"].toString().replaceAll("\\", "");
    //     _makeGetPaymentDataFinal(context, finalUrl);
    //   }
    // }, onError: (error) {
    //   CallApi.displayToast(error.toString());
    // });
  }

  _makeGetPaymentDataFinal(
      BuildContext context, String url, String tkVal) async {
    print("Payment success +++++++++++++++++++" + url);
    // var resultJson2 = await CallApi().sendApiRequest(
    //     visibleLoad: false,
    //     showLoader: true,
    //     url: url,
    //     context: context,
    //     callType: 'get',
    //     tokenVal: tkVal);

    // print(jsonEncode(resultJson2));
    // await ValueStore().secureWriteData('ORDER_ID_VALUE', resultJson2['data']["order_id"]);

    // CallApi().get(context, url, true).then((response) {
    //   if (response != null && response.isNotEmpty) {
    //     Map jsonMap = json.decode(response);
    //     if (jsonMap["responce"]) {
    //       Map<String, dynamic> data = jsonMap["data"];
    //       OrderModel orderModel = OrderModel.fromJson(data);
    //       Navigator.pushReplacement(
    //           context,
    //           PageTransition(
    //               type: CommonUtils.getPageTransition(),
    //               child: Thanks(
    //                 orderModel: orderModel,
    //               )));
    //     }
    //   }
    // }, onError: (error) {
    //   CallApi.displayToast(error.toString());
    // });
  }
}
