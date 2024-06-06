import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/model/Products.dart';
import 'package:shop/shared/StorageService.dart';
import '../../api/Api.dart';
import '../../api/ApiRepo.dart';
import '../../api/response/OrderResponse.dart';
import '../../api/response/ProductResponse.dart';
import '../../globals.dart' as globals;
import '../../model/Products.dart';

class HomeController extends GetxController {

  int rate=0;
  @override
  void onInit() async {
    super.onInit();
    globals.controller=this;
    callMethods();

    //loadBanners();

  }
  void callMethods()async
  {
    Api.setLoading("Please wait");
    await StorageService.LoadUser();
    await getProducts();
    Api.hideLoading();
  }
  void callMyOrders()async
  {
    Api.setLoading("Please wait");
    await getOrders();
    Api.hideLoading();
  }

  var Products = Rxn<ProductResponse>();
  Future<bool> getProducts() async {
    try {
      final result = await ApiRepo().getProducts();
      if (result != null) {
        if (result!=null) {
          Products.value = result;
          Products.refresh();
          return true;
        } else {
        print("getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  var ProductsOrder = Rxn<OrderResponse>();
  Future<bool> getOrders() async {
    try {
      final result = await ApiRepo().getOrders();
      if (result != null) {
        if (result!=null) {
          ProductsOrder.value = result;
          ProductsOrder.refresh();
          return true;
        } else {
          print("getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteOrder(Order products) async {
    try {
      final result = await ApiRepo().deleteOrder(products);
      if (result != null) {
        if (result!=null) {
        await  getOrders();
          return true;
        } else {
          print("getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }


  @override
  void onClose() {
    super.onClose();
  }
   callSearch(String title)async
  {
    Api.setLoading("Please wait");
    try {
      final result = await ApiRepo().getProductsByFilter(title,rate);
      if (result != null) {
        Api.hideLoading();
        if (result!=null) {
          Products.value = result;
          Products.refresh();
          return true;
        } else {
          print("getLatestProducts:: e >>>>> ");
          return false;
        }
      }
      return false;
    } catch (e) {
      Api.hideLoading();
      return false;
    }
  }
  exitApp()async
  {
    await StorageService.ResetInfo();
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
