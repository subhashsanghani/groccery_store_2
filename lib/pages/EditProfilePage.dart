
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart%20';
import 'package:flutter/services.dart';
import 'package:groccery_store_2_2/Components/ColorsFile.dart';
import 'package:groccery_store_2_2/Models/ProfileDataModel.dart';
import 'package:groccery_store_2_2/components/valueStore.dart';
import 'package:groccery_store_2_2/pages/ProfilePage.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();

  int selectedIndex = 0;
  bool isLoad = true;
  ProfileDataModel? profileData;

  RoundedLoadingButtonController _controller =
      new RoundedLoadingButtonController();

  late PickedFile _imagedFile = null as PickedFile;
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedFile;

  @override
  void initState() {
    // TODO: implement initState
    GetProfile();

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
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 20 , top: 10),

            child: Icon(Icons.arrow_back_ios,
                color: appColors.appOrange, size: 18),

          ),
        ),
        title:  myText(title: "Edit Profile", textColor: appColors.appOrange,fontSize: 24,fontWeight: FontWeight.w700,),
        centerTitle: true,


      ),
      body:isLoad==true?
      Center(child: CircularProgressIndicator(color: appColors.appOrange,)):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SizedBox(height: 55),
                // main app bar
                // Row(
                //   children: [
                //     // back button
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: Align(
                //         alignment: Alignment.centerLeft,
                //         child: Container(
                //           height: 40,
                //           width: 40,
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(40),
                //             child: MaterialButton(
                //                 padding: EdgeInsets.zero,
                //                 onPressed: () {},
                //                 child: Center(
                //                     child: Icon(
                //                   Icons.arrow_back_ios,
                //                   color: appColors.appOrange,
                //                   size: 18,
                //                 ))),
                //           ),
                //         ),
                //       ),
                //     ),
                //
                //     Padding(
                //       padding: const EdgeInsets.only(left: 57.0),
                //       child: myText(
                //         title: "Edit Profile",
                //         textColor: appColors.appOrange,
                //         fontSize: 24,
                //         fontWeight: FontWeight.w700,
                //       ),
                //     ),
                //   ],
                // ),
                 SizedBox(height: 30),


                // profile pic
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width / 4.8,
                        width: MediaQuery.of(context).size.width / 4.8,
                        decoration: BoxDecoration(
                            color: appColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: appColors.appOrange)),
                        child: croppedFile == null
                            ? ClipRRect(
                          // clipBehavior: Clip.none,
                          borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(

                                  imageUrl: profileData!.data!.user!.profileUrl.toString(),
                                  placeholder: (context, url) =>
                                      Image.asset('images/placeBasket.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('images/placeBasket.png'),
                                ),
                            )
                            : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(File(croppedFile!.path)))),
                    Positioned(
                      right: -5,
                      bottom: -5,
                      child: Container(
                        height: MediaQuery.of(context).size.width / 10.5,
                        width: MediaQuery.of(context).size.width / 10.5,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5, color: appColors.darkGrey)
                            ],
                            color: appColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: appColors.borderGrey)),
                        child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet<dynamic>(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) => CameraBottom(),
                                  enableDrag: true);
                            },
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey.shade400,
                              size: 15,
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                myText(title:  profileData!.data!.user!.userEmail.toString(), fontSize: 18  , textColor: appColors.textBrown2,),
                SizedBox(height: 30),
                //  name text field
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(

                          controller: fullName,
                          showCursor: true,
                          cursorColor: appColors.appOrange,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter A Valid Name';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                              hintText: "Full Name",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.hint),
                              border: InputBorder.none,
                              errorStyle: TextStyle(height: 1),
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //  mob text field
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
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
                          controller: phone,
                          showCursor: true,
                          cursorColor: appColors.appOrange,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 10) {
                              return 'Enter 10 digit Mobile Number';
                            } else {
                              return null;
                            }
                          },
                          obscureText: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(height: 1),
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                                fontSize: 16,
                                color: appColors.hint,
                                fontWeight: FontWeight.w400),
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //gender selction
                Container(
                  decoration: BoxDecoration(
                    color: appColors.borderGrey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //male
                        Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                              color: selectedIndex == 0
                                  ? appColors.appOrange
                                  : appColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appColors.appOrange)),
                          child: MaterialButton(
                            onPressed: () {
                              selectedIndex = 0;
                              setState(() {});
                            },
                            padding: EdgeInsets.zero,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: myText(
                                title: "Male",
                                textColor: selectedIndex == 0
                                    ? appColors.backgroundWhite
                                    : appColors.textBrown2,
                                fontSize: 16,
                              ),
                            )),
                          ),
                        ),
                        // female
                        Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                              color: selectedIndex == 1
                                  ? appColors.appOrange
                                  : appColors.backgroundWhite,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: appColors.appOrange)),
                          child: MaterialButton(
                            onPressed: () {
                              selectedIndex = 1;
                              setState(() {
                                print(selectedIndex.toString()+"INDEX");
                              });
                            },
                            padding: EdgeInsets.zero,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: myText(
                                title: "Female",
                                textColor: selectedIndex == 1
                                    ? appColors.backgroundWhite
                                    : appColors.textBrown2,
                                fontSize: 16,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //  update profile button
                RoundedLoadingButton(
                  controller: _controller,
                  errorColor: appColors.appOrange,
                  color: appColors.appOrange,
                  animateOnTap: false,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.start();
                      UpdateProfile(
                          imageFIle:croppedFile!=null? File(croppedFile!.path):null,
                          gender: selectedIndex == 0 ? "male" : "female");
                    } else {}
                    setState(() {});
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.width / 6.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: appColors.appOrange,
                        borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Align(
                        alignment: Alignment.center,
                        child: myText(
                          title: "Update Profile",
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
          ),
        ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    // _imagedFile = pickedFile!;
    croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      cropStyle: CropStyle.circle,
      maxWidth: 512,
      maxHeight: 512,
      // compressQuality:12,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: appColors.backgroundWhite,
            // dimmedLayerColor: myColors.red,
            cropFrameStrokeWidth: 2,
            activeControlsWidgetColor: appColors.appOrange,
            cropFrameColor: appColors.appOrange,
            toolbarWidgetColor: appColors.appOrange,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    File? imageFIle = File(croppedFile!.path);

    setState(() {});
    // await apiCall().profileImageChange(urlPath: urlData.profileImageUpdate, updateValue: pickedFile);

    // if(imageJson['success']) print(imageJson['data']['user']['profile_image']);
    // setState(() {
    //   _imagedFile = pickedFile;
    // });
  }

  Widget CameraBottom() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          color: appColors.backgroundWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [appColors.appOrange, Colors.yellow]),
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 68,
                          width: 68,
                          decoration: BoxDecoration(
                            color: appColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(68),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: appColors.appOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    myText(
                        title: "Camera",
                        textColor: appColors.appOrange,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            MaterialButton(
              onPressed: () {
                takePhoto(ImageSource.gallery);
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [appColors.appOrange, Colors.yellow]),
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          height: 68,
                          width: 68,
                          decoration: BoxDecoration(
                            color: appColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(68),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                Icons.image_rounded,
                                color: appColors.appOrange,
                              )),
                        ),
                      ),
                    ),
                    myText(
                      title: "Gallery",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      textColor: appColors.appOrange,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  UpdateProfile({File? imageFIle, String? gender}) async {
    _controller.start();
    setState(() {});

    var myHeader = {"x-api-key": "99e1bb00b05ec7b10343b92815a2e7f4"};

    var request = http.MultipartRequest(
        'POST', Uri.https(apiIp.ipAddress, '/glossary/api/upadateuserdata'));
    request.headers.addAll(myHeader);
    request.fields["user_id"] =await ValueStore().secureReadData("currentUser");
    request.fields["name"] = fullName.text;
    request.fields["mobile"] = phone.text;
    request.fields["gender"] = gender!;
    request.fields["image"] = imageFIle.toString()!;

    imageFIle != null ?

    request.files.add(await http.MultipartFile.fromPath('image', imageFIle.path))
        : ""  ;

    var res = await request.send();
    await http.Response.fromStream(res).then((value) {
      var updatePhotoJson = jsonDecode(value.body);
      print(updatePhotoJson);

      if (updatePhotoJson['success']) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),

        );
        MotionToast(
          position: MOTION_TOAST_POSITION.BOTTOM,
          animationType: ANIMATION.FROM_LEFT,
          animationCurve: Curves.linear,
          icon: Icons.done,
          height: 60,
          borderRadius: 8,
          width: MediaQuery.of(context).size.width/1.035,
          description: updatePhotoJson['message'],
          title: "",
          titleStyle: TextStyle(fontSize: 14),
          animationDuration: Duration(microseconds: 300),
          descriptionStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          toastDuration: Duration(seconds: 2),
          color: Colors.greenAccent.shade400,
        ).show(context);

      }
      else{
        MotionToast(
          position: MOTION_TOAST_POSITION.BOTTOM,
          animationType: ANIMATION.FROM_LEFT,
          animationCurve: Curves.linear,
          icon: Icons.close,
          height: 60,
          borderRadius: 8,
          width: MediaQuery.of(context).size.width/1.035,
          description: updatePhotoJson['message'],
          title: "",
          titleStyle: TextStyle(fontSize: 14),
          animationDuration: Duration(microseconds: 300),
          descriptionStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
          toastDuration: Duration(seconds: 2),
          color: Colors.red.shade400,
        ).show(context);

      }
    });

    _controller.stop();

    setState(() {});
  }

  GetProfile() async {
    isLoad=true;
    setState(() {

    });
    var prores = await http.post(Uri.https(apiIp.ipAddress, "/glossary/api/showprofile"),
        body: {"id": await ValueStore().secureReadData("currentUser")});
    if(prores.statusCode==200){
      var profileJson = jsonDecode(prores.body);
      print(profileJson);


      if(profileJson!=null && profileJson["success"]==true){
        profileData = ProfileDataModel.fromJson(profileJson);
        fullName.text= profileData!.data!.user!.userFullname.toString();
        phone.text =  profileData!.data!.user!.userPhone.toString();
        isLoad=false;
        print("object");
        setState(() {

        }
        );
    }

    }


  }
}
