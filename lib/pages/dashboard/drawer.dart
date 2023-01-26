// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/user_data_bloc.dart';
import 'package:flutter_architecture/models/responses/custom_response/user_profile_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/auth/login_with_otp/login_with_otp.dart';
import 'package:flutter_architecture/pages/dashboard/profile.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/app_colors.dart';

class CustomDrawer extends StatefulWidget {
  UserProfileResponse userProfileResponse;

  CustomDrawer({super.key, required this.userProfileResponse});
  @override
  State<CustomDrawer> createState() => _CustomDrawerState(userProfileResponse);
}

class _CustomDrawerState extends State<CustomDrawer> {
  late UserProfileResponse userProfileResponse;
  _CustomDrawerState(this.userProfileResponse);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            accountName: Text(
              '${userProfileResponse.firstName} ${userProfileResponse.lastName}',
              style: textStyle(fontWeight: FontWeight.bold, size: 20),
            ),
            accountEmail: Text(
              userProfileResponse.mobileNumber,
              style: textStyle(fontWeight: FontWeight.w400, size: 13),
            ),
            currentAccountPicture: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.5,
                  color: AppColors.whiteColor,
                ),
                image: userProfileResponse.image == ""
                    ? const DecorationImage(
                        image: AssetImage('assets/images/placeholder_dp.png'),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: NetworkImage(
                            NetworkConstant.API_PARAM_PROFILE_PIC +
                                userProfileResponse.image)),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);

                Get.to(const Profile());
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: AppColors.primaryColor,
              ),
              title: const Text("LogOut"),
              onTap: () async {
                Navigator.pop(context);
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove(NetworkConstant.TOKEN);
                Get.offAll(const LoginWithOtp());
              },
            ),
          ),
        ],
      ),
    );
  }
  //  void getProfileData() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return const Loading();
  //       });
  //   // Map data = {
  //   //   NetworkConstant.TOKEN: ,
  //   //   NetworkConstant.OTP: otpController.text
  //   // };
  //   userDataBloc!.callGetProfileDataApi(data);
  // }
}
