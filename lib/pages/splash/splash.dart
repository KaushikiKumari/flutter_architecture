import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/auth/login_with_otp/login_with_otp.dart';
import 'package:flutter_architecture/pages/auth/signup.dart';
import 'package:flutter_architecture/pages/dashboard/custom_navbar.dart';
import 'package:flutter_architecture/pages/dashboard/home.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int SplashTimer = 3;
  Timer? _timer;
  void navigate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token;
    try {
      token = sharedPreferences.getString(NetworkConstant.TOKEN)!;
    } catch (e) {
      token = '';
    }
    if (token != '') {
      Get.offAll(const CustomNavBar());
    } else {
      Get.offAll(const LoginWithOtp());
    }
  }

  void startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (SplashTimer == 0) {
        _timer!.cancel();
        navigate();
      } else {
        SplashTimer--;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Text("Splash Page",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    );
  }
}
