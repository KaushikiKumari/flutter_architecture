import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/user_data_bloc.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/user_model.dart';
import 'package:flutter_architecture/models/responses/custom_response/user_profile_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/view_model/user_view_model.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late UserDataBloc userDataBloc;
  bool isLoading = true;
  UserProfileResponse? userSettingsResponse;

  void getSettingsData() async {
    UserModel token = await UserViewModel().getUser();
    Map data = {NetworkConstant.TOKEN: token.token};

    print("****************");
    print(token);
    userDataBloc.callGetUserProfileApi(data);
  }

  @override
  void initState() {
    userDataBloc = UserDataBloc();
    userDataBloc.userDataStream.listen((event) {
      setState(() {
        isLoading = false;
      });
      userSettingsResponse = UserProfileResponse.fromJson(event);
      print("************************************************");
      print(userSettingsResponse.toString());
    });

    getSettingsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                      width: Get.width / 1,
                      decoration: BoxDecoration(
                        color: AppColors.secondryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.5,
                                  color: AppColors.whiteColor,
                                ),
                                image: userSettingsResponse!.image == ""
                                    ? const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/placeholder_dp.png'),
                                        fit: BoxFit.fill)
                                    : DecorationImage(
                                        image: NetworkImage(NetworkConstant
                                                .API_PARAM_PROFILE_PIC +
                                            userSettingsResponse!.image)),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${userSettingsResponse!.firstName} ${userSettingsResponse!.lastName}',
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  userSettingsResponse!.mobileNumber,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            )),
    );
  }
}
