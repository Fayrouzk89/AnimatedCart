
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../globals.dart' as globals;

class MessageHelper {
  static void showMessage(BuildContext context,String msg)
  {
    var snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static bool isLoggedIn()
  {
    /*
    if(globals.userInfo!=null && globals.userInfo!.accessToken!=null && globals.userInfo!.accessToken!="")
    {
      return true;
    }

     */
    return false;
  }
  static void goToLogin(BuildContext context)
  {
    /*
    AuthController controller= AuthController();
    //  Navigator.push(context,MaterialPageRoute(builder: (context) =>  AuthScreen()));
    Get.toNamed(Routes.LOGIN, arguments: controller);

     */
  }
}
