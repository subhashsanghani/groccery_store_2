import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/pages/HomePage.dart';
import 'package:groccery_store_2_2/pages/OrderAcceptedPage.dart';
import 'package:motion_toast/motion_toast.dart';


class Body extends StatelessWidget {
  Body({
    Key? key,
    required this.url,
    required this.controller,
    required this.setWebController,
    required this.onLoadStart,
    required this.onLoadStop,
    required this.onPaymentSuccess,
  }) : super(key: key);

  final String url;
  final InAppWebViewController? controller;
  final Function(InAppWebViewController) setWebController;
  final VoidCallback onLoadStart;
  final VoidCallback onLoadStop;

  final Function(String) onPaymentSuccess;





  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(url)),
      initialOptions: new InAppWebViewGroupOptions(
        android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
        ),
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          cacheEnabled: false,
          clearCache: true,
          javaScriptCanOpenWindowsAutomatically: true,
          supportZoom: false,
          useShouldOverrideUrlLoading: true,
          useShouldInterceptFetchRequest: true,

        ),
      ),
      onWebViewCreated: (controller) {
        setWebController(controller);
      },
      onLoadStop: (controller, url) async {
        onLoadStop();
      },
      onLoadStart: (controller, url) async {
        onLoadStart();
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        var url = navigationAction.request.url.toString();
        //var uri = Uri.parse(url);

        print("overrideUrl::$url");

        bool hasSuccess = RegExp(".*payment/paymentSuccess.*").hasMatch(url);
        bool hasFailed = RegExp(".*payment/paymentFailed.*").hasMatch(url);
        bool hasCanceled = RegExp(".*payment/paypalCancel.*").hasMatch(url);

        if (hasSuccess) {
          print("paymentSuccess");
          onPaymentSuccess(url);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderAccepted()));
          return NavigationActionPolicy.CANCEL;
        } else if (hasFailed) {
          print("paymentFailed");

          return NavigationActionPolicy.CANCEL;
        }else if(hasCanceled) {

          MotionToast(
            icon: Icons.close,
              description:"Payment Has Been Canceled",
            animationCurve: Curves.bounceInOut,
            // position: MOTION_TOAST_POSITION.CENTER,
            animationDuration: Duration(milliseconds: 100),
            toastDuration: Duration(milliseconds: 1500),
            // animationType: ANIMATION.FROM_BOTTOM,
            enableAnimation: true,
            iconSize: 60,
            color: appColors.red
          ).show(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> HomePage(tabPos: 0,) ));
          return NavigationActionPolicy.ALLOW;
        }
        return NavigationActionPolicy.ALLOW;

      },
    );
  }
}
