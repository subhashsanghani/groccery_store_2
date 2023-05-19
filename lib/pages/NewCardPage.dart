import 'package:flutter/material.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewCard extends StatefulWidget {
  const NewCard({Key? key}) : super(key: key);

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  TextEditingController CardNumber = TextEditingController();
  TextEditingController CVV = TextEditingController();
  final _formKey = GlobalKey<FormState>();

 bool  isEmpty = true;

  RoundedLoadingButtonController _buttonController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:isEmpty? Form(
            key: _formKey ,
            child: Column(
              children: [
                SizedBox(height: 55),
                // main app bar
                Row(
                  children: [
                    // back button
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 40,
                          width: 40,

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {

                                },
                                child: Center(child: Icon(Icons.arrow_back_ios,
                                  color: appColors.appOrange, size: 18,))),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 66.0),
                      child: myText(title: "New Card", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                    ),
                  ],
                ),
                SizedBox(height: 50),

              //  Card number text form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(title: "Card Number", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color:appColors.borderGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: CardNumber,
                              showCursor: true,
                              cursorColor: appColors.appOrange,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 16) {
                                  return 'Enter 16 digit card Number';
                                }


                                else {
                                  return null;
                                }
                              },
                              obscureText: false,
                              maxLength: 16,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(height: 1),
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "xxxx xxxx xxxx xxxx",
                                hintStyle: TextStyle(fontSize: 16 , color: appColors.hint , fontWeight: FontWeight.w400),
                                focusedBorder: InputBorder.none,

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              //  expiry date text form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(title: "Expiry Date", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color:appColors.borderGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: CardNumber,
                              showCursor: true,
                              cursorColor: appColors.appOrange,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 16) {
                                  return 'Enter 16 digit card Number';
                                }


                                else {
                                  return null;
                                }
                              },
                              obscureText: false,
                              maxLength: 10,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(height: 1),
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "MM/YY",
                                hintStyle: TextStyle(fontSize: 16 , color: appColors.hint , fontWeight: FontWeight.w400),
                                focusedBorder: InputBorder.none,

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              //  Cvv text Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText(title: "CVV", textColor: appColors.textBrown2,fontSize: 18,fontWeight: FontWeight.w700,),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color:appColors.borderGrey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: CVV,
                              showCursor: true,
                              cursorColor: appColors.appOrange,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 3) {
                                  return "CVV can't be smaller than 3 digits";
                                }


                                else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              maxLength: 4,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(height: 1 ),
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "****",
                                hintStyle: TextStyle(fontSize: 16 , color: appColors.hint , fontWeight: FontWeight.w400 ,),
                                focusedBorder: InputBorder.none,

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 120),
                //  update profile button
                RoundedLoadingButton(
                  controller: _buttonController,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    setState(() {

                    });
                    if (_formKey.currentState!.validate()) {
                      _buttonController.start();

                    } else {

                    }
                  },
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 6.25,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        color: appColors.appOrange,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Align(
                        alignment: Alignment.center,
                        child: myText(
                          title: "Add card",
                          fontWeight: FontWeight.w700,
                          textColor: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ):
          Column(
            children: [
              SizedBox(height: 55),
              // main app bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 40,
                        width: 30,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {

                              },
                              child: Center(child: Icon(Icons.arrow_back_ios,
                                color: appColors.appOrange, size: 18,))),
                        ),
                      ),
                    ),
                  ),
                  // my cards
                  myText(title: "My Cards", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
                  //  plus button
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 40,
                        width: 30,

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: MaterialButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewCard(),));
                              },
                              child: Center(child: Icon(Icons.add,
                                color: appColors.appOrange, size: 22,))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              
            //  no card Image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("images/noCards.png"),
              ),
            // No saved card text
              myText(title: "No Saved Cards", fontSize: 20,fontWeight: FontWeight.w700,textColor: appColors.textBrown2,),
              SizedBox(height: 15),
            //  description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: myText(title: "You can save your card info to make purchase easier, faster.", fontSize:16,fontWeight: FontWeight.w400,textColor: appColors.textBrown2, maxLines: 3,),
              )
            ],
          ),
        ),
      ),
    );
  }
}



