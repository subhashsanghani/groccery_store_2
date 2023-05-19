import 'package:groccery_store_2_2/Components/urlData.dart';

class EndPoint {

  //image prefix url
  static String productImageUrl =
     UrlData.domainName +'/uploads/products/crop/small/';
  static String categoryImgUrl =
      UrlData.domainName + '/uploads/categories/crop/small/';
  static String profileImgUrl =
      UrlData.domainName+'/uploads/profile/crop/small/';
  static String bannerImageUrl =
      UrlData.domainName +'/uploads/banners/';

  static String homeList =  'home/list';


  //user login and register related api
  static String registerUser =  'user/newuser';
  static String loginUser =  'user/login';
  static String forgotPassword =  'user/forgotpassword';
  static String validateOtp =  'user/forgotpasswordverify';
  static String oneSignalRegister =  'user/playerid';


  static String branchList =  'branches';
  static String recentOrderList =  'order/recent_list';
  static String OrderTrack =  'order/track';
  static String orderSend =  'order/send';
  static String orderDetail =  'order/details';
  static String orderCancel =  'order/cancel';
  static String cartReorder =  'cart/reorder';
  static String orderList =  'order/list';
  static String resetPass =  'user/resetpassword';


  //product related url
  static String productDetail =  'products/details';
  // static String productList =  'products/list';
  // static String favouriteList =  'products/favourite_list';
  // static String addFavourite =  'products/favourite';
  // static String removeFavourite =  'products/remove_favourite';
  // static String searchProduct =  'products/search';
  static String popularList =  'popular';
  static String categoriesData =  'products';


//  branch details and location urls
  static String addNewAddress = 'address/add';
  static String addressList = 'getaddress';
  static String deleteAddress = 'deleteaddress';
  static String editAddress= 'address/update';
  static String promoCode = 'coupon/list';
  static String promoValidate = 'coupon/validate';


// settings list url (for min. delivery time)
  static String settingList =  'app_settings';

//  cart related url
  static String addCart =  'cart/add';
  static String cartList =  'cartlist';
  static String removeCart =  'removecartiteam';
  static String updateCart =  'updatecart';
  static String ClearCart =  'clearcart';

//  more fragment related urls ( profile , recent_orders , favourite , my_orders , contact_us , share )
  static String profileDisplay =  'user/profile';
  static String profilePhoto =  'user/photo';
  static String updateProfile =  'user/update_profile';
  static String updatePhone =  'user/update_phone';
  static String updateName =  'user/update_name';
  static String changePassword =  'user/changepassword';
  static String contactUsForm =  'contactus/send';

// ratings url
  static String ratingAdd =  'ratings/add';

  // web view url
  static String termsCon =  'apppages/tnc';
  static String policy =  'apppages/policy';
  static String aboutUs =  'apppages/about';



}


