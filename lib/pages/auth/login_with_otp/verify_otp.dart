// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/auth_data_bloc.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/auth/signup.dart';
import 'package:flutter_architecture/pages/dashboard/custom_navbar.dart';
import 'package:flutter_architecture/pages/dashboard/home.dart';
import 'package:flutter_architecture/shared_preference/shared_pref.dart';
import 'package:flutter_architecture/shared_preference/shared_pref_constant.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/app_strings.dart';
import 'package:flutter_architecture/utilities/constant_strings.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/widgets/loader.dart';
import 'package:flutter_architecture/widgets/toast.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class VerifyOtp extends StatefulWidget {
  String mobileNumber;
  VerifyOtp({super.key, required this.mobileNumber});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  AuthDataBloc? authDataBloc;
  TextEditingController otpController = TextEditingController();
  FocusNode focusNode = FocusNode();

  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    authDataBloc = AuthDataBloc();
    authDataBloc!.otpDataStream.listen((event) {
      Get.back();
      if (event != '0') {
        showSuccessToast('Login Successfully Done.');
        sharedPref.setStringData(event['token'], SharedPrefConstant.TOKEN);
        if (event['is_registered'] == 0) {
          Get.offAll(const SignUp());
        } else {
          Get.offAll(const CustomNavBar());
        }
      }
    });
    super.initState();
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
          AppStrings.otp,
          style: textStyle(
              size: ConstantStrings.font_large, fontWeight: FontWeight.w500),
        ),
      ),
      body: SizedBox(
        height: Get.height / 1,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
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
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red, //this has no effect
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Enter OTP",
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 30, right: 30),
                    child: Bounce(
                      duration: const Duration(milliseconds: 110),
                      onPressed: () {
                        getVerified();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Login",
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
      ),
    );
  }

  void getVerified() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Loading();
        });
    Map data = {
      NetworkConstant.MOBILE_NUMBER: widget.mobileNumber,
      NetworkConstant.OTP: otpController.text
    };
    authDataBloc!.callVerifyOtpApi(data);
  }
}
