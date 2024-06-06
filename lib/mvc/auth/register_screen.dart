import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

import '../../shared/AppBars/MainAppBar.dart';
import '../../shared/LocalString.dart';
import '../../shared/Regex.dart';
import '../../shared/design/ColorConstants.dart';
import '../../shared/design/CommonConstants.dart';
import '../../shared/design/CommonWidget.dart';
import '../../shared/design/SizeConfig.dart';
import '../../shared/inputWidget/InputField.dart';
import '../../shared/inputWidget/InputFieldEmail.dart';
import '../../shared/inputWidget/InputPassword.dart';
import '../../shared/widget/CustomRounded.dart';
import 'auth_controller.dart';
import '../../globals.dart' as globals;
class RegisterScreen extends StatelessWidget {
  final AuthController controller = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar:MainAppBar(),
          backgroundColor: ColorConstants.white,
          body:Container(
    alignment: Alignment.topCenter,
    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
    child: _buildForms(context),
    ),)
      ],
    );
  }

  Widget _buildForms(BuildContext context) {

    return Form(
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocalString.getStringValue(context, 'create_account') ??
                      "أنشئ حساب",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: CommonConstants.normalText,
                      color: ColorConstants.textColor,
                      fontFamily: CommonConstants.largeTextFont),
                )),
            Container(
              height: SizeConfig().screenHeight*0.2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  "images/signup.svg",
                ),
              ),
            ),
            InputField(
              controller: controller.registerFirstController,
              keyboardType: TextInputType.text,
              //labelText: 'Email address',
              placeholder:
              LocalString.getStringValue(context, 'first_name') ??
                  'الاسم الأول',
              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                      context, 'first_required') ??
                      'الاسم حقل مطلوب';
                }

                return null;
              },
              icon: Icons.person,
            ),
            CommonWidget.rowHeight(height: 10.0),
            InputFieldEmail(
              controller: controller.registerEmailController,
              keyboardType: TextInputType.text,
              //labelText: 'Email address',
              placeholder: LocalString.getStringValue(context, 'enter_email') ??
                  'ادخل البريد الالكتروني',
              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                      context, 'email_required') ??
                      'البريد الالكتروني حقل مطلوب';
                }
                if (value != null) {
                  if (!Regex.isEmail(value)) {
                    return LocalString.getStringValue(context, 'email_error') ??
                        'خطأ في صيغة البريد الالكتروني';
                  }
                }
                return null;
              },
              icon: Icons.mail,
            ),
            CommonWidget.rowHeight(height: 10),
            InputPassword(
              controller: controller.registerPasswordController,
              keyboardType: TextInputType.text,
              // labelText: 'Password',
              placeholder:
                  LocalString.getStringValue(context, 'enter_secret') ??
                      'ادخل الرمز السري',
              password: true,

              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                          context, 'password_required') ??
                      'الرمز السري حق مطلوب';
                }



                return null;
              },
              icon: Icons.lock,
            ),
            CommonWidget.rowHeight(height: 10.0),
            InputPassword(
              controller: controller.registerConfirmPasswordController,
              keyboardType: TextInputType.text,
              // labelText: 'Password',
              placeholder:
                  LocalString.getStringValue(context, 'enter_secret_confirm') ??
                      'ادخل تأكيد الرمز السري',
              password: true,

              validator: (value) {
                if (value!.isEmpty) {
                  return LocalString.getStringValue(
                          context, 'password_required') ??
                      'تأكيد الرمز السري حق مطلوب';
                }


                if (controller.registerPasswordController.text !=
                    controller.registerConfirmPasswordController.text) {
                  return LocalString.getStringValue(
                      context, 'password_not_same') ??
                      'الرمز السري غير متطابق';
                }
                return null;
              },
              icon: Icons.lock,
            ),
            CommonWidget.rowHeight(height: 10.0),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: CommonConstants.horizontalPaddingButton,
                    vertical: CommonConstants.verticalPaddingButton),
                child: CustomRounded(
                    text: LocalString.getStringValue(context, 'create_account') ??
                        "انشاء حساب",
                    textSize: CommonConstants.textButton,
                    textColor: Colors.white,
                    color: ColorConstants.greenColor,
                    size: Size(SizeConfig().screenWidth * 0.8,
                        CommonConstants.roundedHeight),
                    pressed: () {
                      controller.register(context);
                    })),
          ],
        ),
      ),
    );
  }

}
