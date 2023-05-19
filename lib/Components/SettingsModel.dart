class SettingsModel {
  bool? success;
  String? message;
  int? code;
  Data? data;

  SettingsModel({this.success, this.message, this.code, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Appsettining? appsettining;

  Data({this.appsettining});

  Data.fromJson(Map<String, dynamic> json) {
    appsettining = json['appsettining'] != null
        ? new Appsettining.fromJson(json['appsettining'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appsettining != null) {
      data['appsettining'] = this.appsettining!.toJson();
    }
    return data;
  }
}

class Appsettining {
  String? name;
  String? copyRight;
  String? website;
  String? currency;
  String? currencySymbol;
  String? mobileCountryCode;
  String? gatewayCharges;
  String? deliveryCharges;
  Null? itemID;
  Null? itemPurchaseCode;
  String? appContact;
  String? appWhatsapp;
  String? appEmail;
  String? billingName;
  Null? billingAddress;
  Null? taxId;
  String? billingContact;
  String? billingEmail;
  Null? billingNote;
  String? billingSignature;
  String? payuMerchantKey;
  String? payuSalt;
  String? razorpayClientId;
  String? razorpayClientSecret;
  String? imApiKey;
  String? imAuthToken;
  String? imUrl;
  String? payVia;
  String? razorpayEnviroment;
  String? iMEnviroment;
  String? payuEnviroment;
  String? enablePayonline;
  String? enableCod;

  Appsettining(
      {this.name,
        this.copyRight,
        this.website,
        this.currency,
        this.currencySymbol,
        this.mobileCountryCode,
        this.gatewayCharges,
        this.deliveryCharges,
        this.itemID,
        this.itemPurchaseCode,
        this.appContact,
        this.appWhatsapp,
        this.appEmail,
        this.billingName,
        this.billingAddress,
        this.taxId,
        this.billingContact,
        this.billingEmail,
        this.billingNote,
        this.billingSignature,
        this.payuMerchantKey,
        this.payuSalt,
        this.razorpayClientId,
        this.razorpayClientSecret,
        this.imApiKey,
        this.imAuthToken,
        this.imUrl,
        this.payVia,
        this.razorpayEnviroment,
        this.iMEnviroment,
        this.payuEnviroment,
        this.enablePayonline,
        this.enableCod});

  Appsettining.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    copyRight = json['CopyRight'];
    website = json['Website'];
    currency = json['Currency'];
    currencySymbol = json['Currency_Symbol'];
    mobileCountryCode = json['Mobile_Country_Code'];
    gatewayCharges = json['Gateway_Charges'];
    deliveryCharges = json['Delivery_Charges'];
    itemID = json['Item_ID'];
    itemPurchaseCode = json['Item_Purchase_Code'];
    appContact = json['app_contact'];
    appWhatsapp = json['app_whatsapp'];
    appEmail = json['App_email'];
    billingName = json['billing_name'];
    billingAddress = json['billing_address'];
    taxId = json['tax_id'];
    billingContact = json['billing_contact'];
    billingEmail = json['billing_email'];
    billingNote = json['billing_note'];
    billingSignature = json['billing_signature'];
    payuMerchantKey = json['payu_merchant_key'];
    payuSalt = json['payu_salt'];
    razorpayClientId = json['razorpay_client_id'];
    razorpayClientSecret = json['razorpay_client_secret'];
    imApiKey = json['im_api_key'];
    imAuthToken = json['im_auth_token'];
    imUrl = json['im_url'];
    payVia = json['pay_via'];
    razorpayEnviroment = json['razorpay_enviroment'];
    iMEnviroment = json['IM_enviroment'];
    payuEnviroment = json['payu_enviroment'];
    enablePayonline = json['enable_payonline'];
    enableCod = json['enable_cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['CopyRight'] = this.copyRight;
    data['Website'] = this.website;
    data['Currency'] = this.currency;
    data['Currency_Symbol'] = this.currencySymbol;
    data['Mobile_Country_Code'] = this.mobileCountryCode;
    data['Gateway_Charges'] = this.gatewayCharges;
    data['Delivery_Charges'] = this.deliveryCharges;
    data['Item_ID'] = this.itemID;
    data['Item_Purchase_Code'] = this.itemPurchaseCode;
    data['app_contact'] = this.appContact;
    data['app_whatsapp'] = this.appWhatsapp;
    data['App_email'] = this.appEmail;
    data['billing_name'] = this.billingName;
    data['billing_address'] = this.billingAddress;
    data['tax_id'] = this.taxId;
    data['billing_contact'] = this.billingContact;
    data['billing_email'] = this.billingEmail;
    data['billing_note'] = this.billingNote;
    data['billing_signature'] = this.billingSignature;
    data['payu_merchant_key'] = this.payuMerchantKey;
    data['payu_salt'] = this.payuSalt;
    data['razorpay_client_id'] = this.razorpayClientId;
    data['razorpay_client_secret'] = this.razorpayClientSecret;
    data['im_api_key'] = this.imApiKey;
    data['im_auth_token'] = this.imAuthToken;
    data['im_url'] = this.imUrl;
    data['pay_via'] = this.payVia;
    data['razorpay_enviroment'] = this.razorpayEnviroment;
    data['IM_enviroment'] = this.iMEnviroment;
    data['payu_enviroment'] = this.payuEnviroment;
    data['enable_payonline'] = this.enablePayonline;
    data['enable_cod'] = this.enableCod;
    return data;
  }
}