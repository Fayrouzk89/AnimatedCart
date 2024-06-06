import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as globals;
import '../api/response/LoginReponse.dart';
import '../model/UserInfo.dart';
import 'StorageConstants.dart';
class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return SharedPreferences.getInstance();
  }
  static Future<bool> saveLang(String lang) async {
    globals.lang=lang;
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.lang, lang);
    prefs.commit();
    return true;
  }


  static Future<bool> saveUserInfo(Data user) async {

    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.accessToken, user.token!);
    prefs.setString(StorageConstants.first_name, user.name!);
    prefs.commit();
    LoadUser();
    return true;
  }
  static Future<bool> LoadUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    globals.lang = sharedPreferences.getString('lang') ?? '';
    String first_name = sharedPreferences.getString(
        StorageConstants.first_name) ??
        "";
    String accessToken = sharedPreferences.getString(
        StorageConstants.accessToken) ?? "";


    UserInfo userInfo = UserInfo(id: 0,
        first_name: first_name,
        second_name: '',
        password: "",
        password_confirmation: "",
        gender: 'gender',
        type: 'type', email: '');
    userInfo.accessToken=accessToken;

    globals.userInfo=userInfo;
    return true;
  }


/*
  static Future<bool> updateUserInfo(UpdateProfile user) async {

    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.mobile, user.mobile);
    prefs.setString(StorageConstants.first_name, user.firstName);
    prefs.setString(StorageConstants.last_name, user.lastName);
    prefs.setString(StorageConstants.gender, user.gender);
    prefs.setString(StorageConstants.type, user.type);
    prefs.setString(StorageConstants.photo_profile, user.photoProfile);
    prefs.setInt(StorageConstants.city_id, user.city_id??0);

    prefs.commit();
    await LoadUser();
    return true;
  }

  static Future<String> getDevice(BuildContext context) async {
    String res = "";
    try
    {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        res = build.brand; // reset when device factory reset.
      }
      else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        res = data.model;
      }
    }
    catch(e) {
      String err = e.toString();
    }
    return res;
  }
  static Future<bool> LoadToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    globals.fcm = sharedPreferences.getString(StorageConstants.fcmFireBase) ?? '';
    return true;
  }
  static Future<bool> LoadUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    globals.lang = sharedPreferences.getString('lang') ?? '';
    globals.fcm = sharedPreferences.getString(StorageConstants.fcmFireBase) ?? '';
    int id = sharedPreferences.getInt(StorageConstants.id) ?? -1;

    String first_name = sharedPreferences.getString(
        StorageConstants.first_name) ??
        "";
    String second_name = sharedPreferences.getString(
        StorageConstants.last_name) ??
        "";
    String gender = sharedPreferences.getString(StorageConstants.gender) ??
        "";
    String type = sharedPreferences.getString(StorageConstants.type) ??
        "";
    String photo = sharedPreferences.getString(
        StorageConstants.photo_profile) ??
        "";
    //TO DO
    String mobile = sharedPreferences.getString(StorageConstants.mobile) ?? "";
    String fcmToken = sharedPreferences.getString(StorageConstants.fcmToken) ??
        "";
    String accessToken = sharedPreferences.getString(
        StorageConstants.accessToken) ?? "";
    String deviceType = sharedPreferences.getString(
        StorageConstants.deviceType) ?? "";
    int numAdvs = sharedPreferences.getInt(StorageConstants.numAdvs) ?? 0;
    int city_id=sharedPreferences.getInt(StorageConstants.city_id) ?? 0;
    int country_id=sharedPreferences.getInt(StorageConstants.country_id) ?? 0;

    UserInfo userInfo = UserInfo(id: id,
        first_name: first_name,
        second_name: second_name,
        mobile: mobile,
        password: "",
        password_confirmation: "",
        gender: gender,
        type: type);
    userInfo.accessToken=accessToken;
    userInfo.fcmToken=fcmToken;
    userInfo.profile = photo;
    userInfo.cityId=city_id;
    userInfo. countryId=country_id;
    if (id == -1)
    {
      globals.userInfo=null;
    }
    else
      globals.userInfo=userInfo;
    return true;
  }
  static void SignOutUser() {
    ResetInfo();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

 */
  static Future ResetInfo()async {
    var prefs = Get.find<SharedPreferences>();
    prefs.setString(StorageConstants.first_name, "");
    prefs.setString(StorageConstants.accessToken,"");
    globals.userInfo=null;
    prefs.commit();
    globals.userInfo=null;

  }



}