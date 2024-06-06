import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../PublicController.dart';
import '../../api/Api.dart';
import '../../api/ApiRepo.dart';
import '../../api/LogUtil.dart';
import '../../api/response/LoginReponse.dart';
import '../../model/UserInfo.dart';
import '../../routes/app_pages.dart';
import '../../globals.dart' as globals;
import '../../shared/AppFocus.dart';
import '../../shared/LocalString.dart';
import '../../shared/MessageHelper.dart';
import '../../shared/StorageService.dart';
import '../../globals.dart' as globals;
class AuthController extends GetxController {

  AuthController();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final registerFirstController = TextEditingController();
  final registerLastController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  String gender="male";
  String individual="";
  bool registerTermsChecked = false;
  String city="";

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final loginStaffController = TextEditingController();
  final loginPasswordController = TextEditingController();

  GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();
  final forgetPhoneController = TextEditingController();

  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  TextEditingController newTextEditingController = TextEditingController();


  final GlobalKey<FormState> activateFormKey = GlobalKey<FormState>();
  String codeActivation="";
  String codeDeletion="";
  FocusNode focusNode = FocusNode();
  String code="";


  final GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController newPasswordConfirmPasswordController = TextEditingController();
  //StreamController<ErrorAnimationType>? errorController = StreamController<ErrorAnimationType>();

  //TextEditingController textEditingController = TextEditingController();
  GlobalKey<FormState> deleteFormKey = GlobalKey<FormState>();
  final deletePhoneController = TextEditingController();
  final deletePasswordController = TextEditingController();
  GlobalKey<FormState> deleteResetFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    print('init auth');
    callInit();
  }
  callInit()async
  {
  // await getCountriesResponse();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void register(BuildContext context) async {
    AppFocus.unfocus(context);
    if (registerFormKey.currentState!.validate()) {
      // Get.toNamed(Routes.HOME);
      UserInfo userInfo = UserInfo( id: 0,
          first_name: registerFirstController.text,
          second_name: registerLastController.text,
          gender: gender,
          password: registerPasswordController.text,
          password_confirmation: registerConfirmPasswordController.text,
          type:individual, email: registerEmailController.text
      );
      globals.userInfo=userInfo;
      RegisterUser(context,userInfo);
    }
  }
  Future<LoginResponse?> RegisterUser(BuildContext context,UserInfo userInfo) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().registerUser(userInfo);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processRegisterResult(result, context);
          return result;
        } else {
          processRegisterResult(result, context);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processRegisterResult(null, context);
      return null;
    }
  }
  void processRegisterResult(LoginResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.success==true)
      {
        if(response.data!=null && response.data!=null) {
          MessageHelper.showMessage(context,response.message!);
          StorageService.saveUserInfo(response.data!);
          // Get.clearRouteTree();
          // Get.offNamedUntil(Routes.HOME', (route) => false);;
          PublicController.openHome(context);
        }
        else
        {
          processFailRegister(response,context);
        }
      }
      else
      {
        processFailRegister(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processFailRegister(LoginResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message!);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_register') ??
          'خطأ في التسجيل يرجى التحقق من المعلومات');
    }
  }
  Future<LoginResponse?> login(BuildContext context,UserInfo userInfo) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      try {
        final result = await ApiRepo().validateUser(userInfo);
        Api.hideLoading();
        if (result!=null) {
          processResult(result, context);
          return result;
        } else {
          processResult(result, context);
        }
      } catch (e) {
        print("RegisterUser:: e >>>>> ");
        Api.hideLoading();
        processResult(null, context);
      }
    }
  }
  void processResult(LoginResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.success==true)
      {
        if(response.data!=null && response.data!.name!=null) {
          StorageService.saveUserInfo(response.data!);
          // Get.clearRouteTree();
          // Get.offNamedUntil(Routes.HOME', (route) => false);;
          PublicController.openHome(context);
        }
        else
        {
          processFailLogin(response,context);
        }
      }
      else
      {
        processFailLogin(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processFailLogin(LoginResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message!);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_login') ??
          'خطأ في تسجيل الدخول يرجى التحقق من المعلومات');
    }
  }
  /*
  Future<CreateAccountResponse?> RegisterUser(BuildContext context,UserInfo userInfo) async {
    Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
        'يرجى الانتظار');
    try {
      final result = await ApiRepo().registerUser(userInfo);
      Api.hideLoading();
      if (result != null) {
        if (result!=null) {
          processRegisterResult(result, context);
          return result;
        } else {
          processRegisterResult(result, context);
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      Log.loga(title, "RegisterUser:: e >>>>> $e");
      Api.hideLoading();
      processRegisterResult(null, context);
      return null;
    }
  }
  Future<LoginResponse?> login(BuildContext context,UserInfo userInfo) async {
    AppFocus.unfocus(context);
    if (loginFormKey.currentState!.validate()) {
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      String deviceType= await StorageService.getDevice(context);
      userInfo.deviceType=deviceType;
      try {
        final result = await ApiRepo().validateUser(userInfo);
        Api.hideLoading();
        if (result!=null) {
          processResult(result, context);
          return result;
        } else {
          processResult(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        processResult(null, context);
      }
    }
  }
  void processResult(LoginResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(response.data!=null && response.data.user!=null) {
          StorageService.saveUserInfo(response.data.user);
          // Get.clearRouteTree();
          // Get.offNamedUntil(Routes.HOME', (route) => false);;
          if(Get.previousRoute==Routes.HOME)
          {
            Get.back();
          }
          else {
            Get.toNamed(Routes.HOME);
          }
        }
        else
        {
          processFailLogin(response,context);
        }
      }
      else
      {
        processFailLogin(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processRegisterResult(CreateAccountResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(response.data!=null && response.data!=null) {
          MessageHelper.showMessage(context,response.message!);
          globals.activateMsg=response.message!;
          Get.toNamed(Routes.AUTH + Routes.activate,
              arguments: this);
        }
        else
        {
          processFailRegister(response,context);
        }
      }
      else
      {
        processFailRegister(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processFailRegister(CreateAccountResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_register') ??
          'خطأ في التسجيل يرجى التحقق من المعلومات');
    }
  }
  void processFailLogin(LoginResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      if(response.code==Api.code_activate)
      {
        globals.activateMsg=response.message!;
        Get.toNamed(Routes.AUTH + Routes.activate,
            arguments: this);
      }
      else
        MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_login') ??
          'خطأ في تسجيل الدخول يرجى التحقق من المعلومات');
    }
  }
  void forget(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (forgetFormKey.currentState!.validate()) {
      UserInfo userInfo = UserInfo( id: 0,
          first_name: "",
          second_name:"",
          gender: "",
          mobile: forgetPhoneController.text,
          password: "",
          password_confirmation: "",
          type:""
      );
      globals.userInfo=userInfo;
      forgetCall(context,1);

    }
  }
  void deleteAccount(BuildContext context,AuthController controller) async {
    AppFocus.unfocus(context);
    if (deleteFormKey.currentState!.validate()) {
      UserInfo userInfo = UserInfo( id: 0,
          first_name: "",
          second_name:"",
          gender: "",
          mobile: deletePhoneController.text,
          password: deletePasswordController.text,
          password_confirmation: "",
          type:""
      );
      globals.userInfo=userInfo;
      deleteCall(context);

    }
  }
  Future<GeneralResponse?> deleteCall(BuildContext context) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      try {
        final result = await ApiRepo().deleteCall(userInfo!);//MHD
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcessDelete(result, context);
          return result;
        } else {
          GeneralResponseProcessDelete(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcessDelete(null, context);
      }
    }
  }
  void GeneralResponseProcessDelete(GeneralResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        globals.activateMsg=response.message;
        Get.toNamed(Routes.AUTH + Routes.DeleteReset, arguments: this);
      }
      else
      {
        MessageHelper.showMessage(context,response.message);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  Future<GeneralResponse?> forgetCall(BuildContext context,int id) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      try {
        final result = await ApiRepo().forget_password(userInfo!);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcessForget(result, context,id);
          return result;
        } else {
          GeneralResponseProcessForget(result, context,id);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcessForget(null, context,id);
      }
    }
  }
  void GeneralResponseProcessForget(GeneralResponse? response,BuildContext context,int id)
  {
    if(response!=null)
    {
      if(response.status)
      {
        if(id==1) {
          globals.activateMsg= response.message??"";
          Get.toNamed(Routes.AUTH + Routes.Reset, arguments: this);
        }
        else
        {
          MessageHelper.showMessage(context,response.message);
        }
        //else
        //  Get.toNamed(Routes.AUTH + Routes.LOGIN,arguments: this);
      }
      else
      {
        processFailForget(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }

  Future<GeneralResponse?> verifyAccount(BuildContext context,String code) async {
    if(globals.userInfo!=null) {
      UserInfo? userInfo = globals.userInfo;
      Api.setLoading(LocalString.getStringValue(context, 'pleaseWait') ??
          'يرجى الانتظار');
      userInfo!.otp_code = code;
      try {
        final result = await ApiRepo().verifyUser(userInfo);
        Api.hideLoading();
        if (result != null) {
          GeneralResponseProcess(result, context);
          return result;
        } else {
          GeneralResponseProcess(result, context);
        }
      } catch (e) {
        Log.loga(title, "RegisterUser:: e >>>>> $e");
        Api.hideLoading();
        GeneralResponseProcess(null, context);
      }
    }
  }
  void GeneralResponseProcess(GeneralResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        loginFormKey=GlobalKey<FormState>();
        Get.toNamed(Routes.AUTH + Routes.LOGIN,
            arguments: this);
      }
      else
      {
        processFailActiate(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void ProcessDelete(GeneralResponse? response,BuildContext context)
  {
    if(response!=null)
    {
      if(response.status)
      {
        MessageHelper.showMessage(context,response.message);
        loginFormKey=GlobalKey<FormState>();
        Get.toNamed(Routes.AUTH + Routes.LOGIN,
            arguments: this);
      }
      else
      {
        processFailActiate(response,context);
      }
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'time_out') ??
          'تايم اوت');
    }
  }
  void processFailActiate(GeneralResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_activate') ??
          'خطأ في كود التفعيل يرجى التحقق من المعلومات');
    }
  }
  void processFailForget(GeneralResponse response,BuildContext context)
  {
    if(response.message!=null)
    {
      MessageHelper.showMessage(context,response.message);
    }
    else
    {
      MessageHelper.showMessage(context,LocalString.getStringValue(
          context, 'error_forget') ??
          'خطأ في العملية  يرجى التحقق من المعلومات');
    }
  }

  @override
  void onClose() {
    super.onClose();
    globals.userInfo=null;
    registerFirstController.dispose();
    registerLastController.dispose();
    registerPhoneController.dispose();
    registerConfirmPasswordController.dispose();
    registerPasswordController.dispose();
    gender="male";
    individual="";
    loginStaffController.dispose();
    loginPasswordController.dispose();
    code="";
    codeActivation="";
    city="";
    //  newPasswordFormKey.dispose();
    newPasswordEditingController.dispose();
    newPasswordConfirmPasswordController.dispose();
    //textEditingController.dispose();
    focusNode.dispose();
  }
  Cities? selectedCity;
  DataCountry? selectedCountry;
  var countries =Rxn<CountriesResponse>();
  Future<CountriesResponse?> getCountriesResponse() async {
      try {
        if(globals.countries==null) {
          final result = await ApiRepo().getCountries();
          //  Api.hideLoading();
          if (result != null) {
            if (result != null) {
              globals.countries = result;
              countries.value = result;
              if (countries != null && countries.value != null &&
                  countries.value!.data != null &&
                  countries.value!.data!.length > 0) {
                globals.phonePrefix= countries.value!.data![0].key!;
                globals.phonelength= countries.value!.data![0].mobile_numbers!;
                selectedCountry = countries.value!.data![0];
              }
              countries.refresh();
            } else {
              Log.loga(title, "getPackages:: e >>>>> ");
            }
          }
          else {
            return null;
          }
        }
        else
          {
            updateCountries();
          }

      } catch (e) {
        Log.loga(title, "getPackages:: e >>>>> $e");
       // Api.hideLoading();
        return null;
      }

  }
  updateCountries()
  {
    countries.value=globals.countries;
    if(countries!=null && countries.value!=null && countries.value!.data!=null && countries.value!.data!.length>0)
    {
      selectedCountry=countries.value!.data![0];
    }
    countries.refresh();
  }

   */
}
