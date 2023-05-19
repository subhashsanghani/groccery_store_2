import 'package:flutter/material.dart';

import 'OrdersPage.dart';
import '../Components/ColorsFile.dart';

class orderCanceledPage extends StatefulWidget {
  const orderCanceledPage({Key? key}) : super(key: key);

  @override
  State<orderCanceledPage> createState() => _orderCanceledPageState();
}

class _orderCanceledPageState extends State<orderCanceledPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 75),
            //  image
            Image.asset('images/acceptimage.png'),
            SizedBox(height: 35),
            //  text header
            myText(title: "Oops! Order Failed!", textColor: appColors.textBrown,fontSize: 20,fontWeight: FontWeight.w700,),
            SizedBox(height: 16),
            // main text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: myText(title: "Something went terribly wrong",
                  textColor: appColors.textBrown,fontSize: 16,fontWeight: FontWeight.w400,maxLines: 5,textAlign: TextAlign.center),
            ),
            SizedBox(height: 50),
            //  track order button
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: appColors.appOrange
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage(),));
                    },
                    child: Center(child: myText(title: "try Again", textColor: appColors.backgroundWhite,fontSize: 17, fontWeight: FontWeight.w700,))),
              ),
            ),

            SizedBox(height: 16),
            //  Back Home button
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: appColors.backgroundWhite,
                border: Border.all(color: appColors.appOrange),
              ),
              child: Center(child: myText(title: "Back Home", textColor: appColors.appOrange,fontSize: 17, fontWeight: FontWeight.w700,)),
            ),

          ],
        ),
      ),

    );
  }
}
