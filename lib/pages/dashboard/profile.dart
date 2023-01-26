import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/user_data_bloc.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/user_model.dart';
import 'package:flutter_architecture/models/responses/custom_response/user_profile_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/dashboard/edit_profile.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/app_strings.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/view_model/user_view_model.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserDataBloc userDataBloc;
  bool isLoading = true;
  UserProfileResponse? userProfileResponse;

  void getProfileData() async {
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
      userProfileResponse = UserProfileResponse.fromJson(event);
      print("************************************************");
      print(userProfileResponse.toString());
    });

    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(EditProfile());
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 25.0, 15.0, 0.0),
              child: Text(
                AppStrings.editProfile,
                style: textStyle(size: 14, color: AppColors.whiteColor),
              ),
            ),
          )
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.5,
                        color: AppColors.whiteColor,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.greyColor,
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3))
                      ],
                      image: userProfileResponse!.image == ""
                          ? const DecorationImage(
                              image: AssetImage(
                                  'assets/images/placeholder_dp.png'),
                              fit: BoxFit.fill)
                          : DecorationImage(
                              image: NetworkImage(
                                  NetworkConstant.API_PARAM_PROFILE_PIC +
                                      userProfileResponse!.image)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${userProfileResponse!.firstName} ${userProfileResponse!.lastName}',
                        style: textStyle(
                            color: AppColors.secondryColor,
                            size: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userProfileResponse!.mobileNumber,
                        style: textStyle(
                            color: AppColors.secondryColor,
                            size: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: Get.width / 1,
                      decoration: BoxDecoration(
                        color: AppColors.secondryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.face,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  AppStrings.gender,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  userProfileResponse!.gender,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  AppStrings.dob,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  userProfileResponse!.dob,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  AppStrings.tob,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  userProfileResponse!.dobTime,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  AppStrings.city,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  userProfileResponse!.city,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  AppStrings.state,
                                  style: textStyle(
                                      color: Colors.white,
                                      size: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 15),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  color: AppColors.whiteColor,
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  userProfileResponse!.state,
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
