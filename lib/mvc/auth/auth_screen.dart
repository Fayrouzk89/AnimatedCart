import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/AppBars/MainAppBar.dart';
import '../../shared/AppFont.dart';
import '../../shared/LocalString.dart';
import '../../shared/design/ColorConstants.dart';
import '../../shared/design/CommonConstants.dart';
import '../../shared/design/SizeConfig.dart';
import '../../shared/widget/CustomRounded.dart';
import 'auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AuthScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: ColorConstants.whiteBack,
        appBar: MainAppBar(),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: CommonConstants.paddingBottom),
              child: Container(
                  alignment: Alignment.topCenter,
                  color: ColorConstants.whiteBack,
                  padding: EdgeInsets.symmetric(
                      horizontal: CommonConstants.paddingHorizontal),
                  child: _buildItems(context)),
            ),
            //FooterWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      children: [
        Container(
          height: SizeConfig().screenHeight*0.3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset(
              "images/chat.svg",
            ),
          ),
        ),
        Text(
        LocalString.getStringValue(context, 'app_name') ?? "كار اونلاين",
          //textAlign: TextAlign.center,
          style: AppFont.bold.copyWith(
              color: ColorConstants.black,
              fontWeight: FontWeight.bold,
              fontSize: CommonConstants.meduimText),
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: CommonConstants.horizontalPaddingButton,
                vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
              text: LocalString.getStringValue(context, 'sign_in') ??
                  "تسجيل الدخول",
              textSize: CommonConstants.textButton,
              textColor:Colors.white ,
              color:ColorConstants.greenColor   ,
              size: Size(SizeConfig().screenWidth * 0.8,
                  CommonConstants.roundedHeight),
              pressed: () {
                Get.toNamed(Routes.AUTH + Routes.LOGIN,
                    arguments: controller);
              },
            )),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: CommonConstants.horizontalPaddingButton,
                vertical: CommonConstants.verticalPaddingButton),
            child: CustomRounded(
                text: LocalString.getStringValue(context, 'create_account') ??
                    "إنشاء حساب",
                textSize: CommonConstants.textButton,
                textColor:ColorConstants.greenColor ,
                color:Colors.white ,
                size: Size(SizeConfig().screenWidth * 0.8,
                    CommonConstants.roundedHeight),
                pressed: () {
                  Get.toNamed(Routes.AUTH + Routes.REGISTER, arguments: controller);
                })),
        SizedBox(height: 10.0),
        /*
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
              //  Get.toNamed(Routes.HOME);
              },
              child: Text(
                LocalString.getStringValue(context, 'have_account') ??
                    "هل لديك حساب",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: CommonConstants.normalText,
                    color: ColorConstants.textColor,
                    fontFamily: CommonConstants.largeTextFont,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.AUTH + Routes.LOGIN,
                    arguments: controller);
              },
              child: Text(
                LocalString.getStringValue(context, 'click_here') ??
                    "click_here",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: CommonConstants.normalText,
                    color: ColorConstants.greenColor,
                    fontFamily: CommonConstants.largeTextFont,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

         */
      ],
    );
  }
}
