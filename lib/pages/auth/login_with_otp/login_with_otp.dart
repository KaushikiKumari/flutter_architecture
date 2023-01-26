import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/auth_data_bloc.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/auth/login_with_otp/verify_otp.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/app_strings.dart';
import 'package:flutter_architecture/utilities/constant_strings.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/widgets/loader.dart';
import 'package:flutter_architecture/widgets/toast.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class LoginWithOtp extends StatefulWidget {
  const LoginWithOtp({super.key});

  @override
  State<LoginWithOtp> createState() => _LoginWithOtpState();
}

class _LoginWithOtpState extends State<LoginWithOtp> {
  AuthDataBloc? authDataBloc;
  TextEditingController mobileNumberController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    authDataBloc = AuthDataBloc();
    authDataBloc!.loginDataStream.listen((event) {
      Get.back();
      showSuccessToast(event.message);
      if (event.statusCode == 200) {
        Get.to(VerifyOtp(
          mobileNumber: mobileNumberController.text,
        ));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    authDataBloc!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.loginWithOtp,
          style: textStyle(
              size: ConstantStrings.font_large, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: Get.height / 2.5,
          width: Get.width / 1,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    focusNode: focusNode,
                    textAlign: TextAlign.center,
                    controller: mobileNumberController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red, //this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Mobile Number",
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      focusNode.unfocus();
                      getLogin();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Get Otp",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      )),
    );
  }

  void getLogin() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Loading();
        });
    Map data = {NetworkConstant.MOBILE_NUMBER: mobileNumberController.text};
    authDataBloc!.callLoginApi(data);
  }
}
