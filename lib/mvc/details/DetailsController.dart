import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/shared/MessageHelper.dart';

import '../../api/Api.dart';
import '../../api/ApiRepo.dart';
import '../../model/Products.dart';


class DetailsController extends GetxController {
  final Products product;
  var Product_details = Rxn<Products>();
  DetailsController(this.product);
  @override
  void onInit() {
    super.onInit();
   // callMethods();
  }
  Future callMethods()async
  {
    Api.setLoading("Please wait");
    await getProducts();
    Api.hideLoading();
  }
  Future<bool> getProducts() async {
    try {

      final result = await ApiRepo().getProductbyId(product.id!);
      if (result != null) {
        if (result!=null) {
          Product_details.value = result;
          Product_details.refresh();
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
  addComment(Products products,String text)async
  {
    try {
      Api.setLoading("Please wait");
      final result = await ApiRepo().addProductComment(product.id!,text);
      if (result != null) {
        if (result!=null) {
          await callMethods();
          Api.hideLoading();
          return true;
        } else {
          Api.hideLoading();
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
  addRate(Products products,double rate)async
  {
    try {
      Api.setLoading("Please wait");
      final result = await ApiRepo().addProductRate(product.id!,rate);
      if (result != null) {
        if (result!=null) {
          await callMethods();
          Api.hideLoading();
          return true;
        } else {
          Api.hideLoading();
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
  addproductToOrder(Products products,BuildContext context)async
  {
    try {
      Api.setLoading("Please wait");
      final result = await ApiRepo().addProductOrder(product.id!);
      if (result != null) {
        if (result.success==true) {
          Api.hideLoading();
          DisplayMessage(result.message!,context);

          return true;
        } else {
          Api.hideLoading();
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
  DisplayMessage(String message,BuildContext context)
  {
    MessageHelper.showMessage(context,message);
    Get.back();
  }
  @override
  void onReady() {
    super.onReady();
  }


  @override
  void onClose() {
    super.onClose();
  }
}
