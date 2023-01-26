// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/bloc/user_data_bloc.dart';
import 'package:flutter_architecture/models/responses/custom_response/user/user_model.dart';
import 'package:flutter_architecture/models/responses/custom_response/user_profile_response.dart';
import 'package:flutter_architecture/networking/network_constant.dart';
import 'package:flutter_architecture/pages/dashboard/drawer.dart';
import 'package:flutter_architecture/pages/dashboard/explore.dart';
import 'package:flutter_architecture/pages/dashboard/home.dart';
import 'package:flutter_architecture/pages/dashboard/plan.dart';
import 'package:flutter_architecture/pages/dashboard/profile.dart';
import 'package:flutter_architecture/pages/dashboard/settings.dart';
import 'package:flutter_architecture/utilities/app_colors.dart';
import 'package:flutter_architecture/utilities/string_styles.dart';
import 'package:flutter_architecture/view_model/user_view_model.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;
  final _Views = [
    Home(),
    Plan(),
    Explore(),
    Settings(),
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late UserDataBloc userDataBloc;
  bool isLoading = true;

  UserProfileResponse? userProfileResponse;

  void getProfileData() async {
    UserModel token = await UserViewModel().getUser();

    Map data = {NetworkConstant.TOKEN: token.token};

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
    });
    print("******************************");
    print(userProfileResponse);
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: isLoading == true
          ? Container()
          : CustomDrawer(
              userProfileResponse: userProfileResponse!,
            ),
      //  drawer: Drawer(),
      appBar: AppBar(
        elevation: 1,
        surfaceTintColor: AppColors.primaryColor,
        foregroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.grey.shade50,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.notes,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        leadingWidth: 30,
        title: isLoading == true
            ? Container()
            : Row(
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
                      image: userProfileResponse!.image == ''
                          ? DecorationImage(
                              image: AssetImage(
                                  'assets/images/user_default_image.png'),
                              fit: BoxFit.fill)
                          : DecorationImage(
                              image: NetworkImage(
                                  NetworkConstant.API_PARAM_PROFILE_PIC +
                                      userProfileResponse!.image)),
                    ),
                  ),
                  SizedBox(width: 5),
                  // Text(
                  //   Strings.WELCOME,
                  //   style: smallDullTextStyle,
                  // ),
                  SizedBox(width: 2),
                  Text(
                    '${userProfileResponse!.firstName} ${userProfileResponse!.lastName}',
                    style: textStyle(size: 15),
                  ),
                ],
              ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
          //   child: Container(
          //       height: 30,
          //       width: 90,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           border:
          //               Border.all(color: Colors.grey.shade300, width: 0.5)),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Text(
          //             'Today',
          //             style:
          //                 altraSmallTextStyle.apply(color: AppColors.dullColor),
          //           ),
          //           Icon(
          //             Icons.arrow_drop_down,
          //             color: AppColors.greyColor,
          //             size: 19,
          //           )
          //         ],
          //       )),
          // ),

          IconButton(
              onPressed: () {
                //  Get.to(NotificationsView());
              },
              icon: Icon(
                Icons.notifications,
                color: AppColors.whiteColor,
                size: 25,
              ))
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _Views[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: AppColors.greyColor,
              )
            ],
          ),
          child: SizedBox(
            width: Get.width / 1,
            height: Get.height / 12,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: _selectedIndex == 0
                                    ? Icon(Icons.home_filled,
                                        color: AppColors.primaryColor)
                                    : Icon(Icons.home_outlined,
                                        color: AppColors.greyColor)),
                            const SizedBox(height: 5),
                            Text("Home",
                                style: _selectedIndex == 0
                                    ? textStyle(color: AppColors.primaryColor)
                                    : textStyle(color: AppColors.greyColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: _selectedIndex == 1
                                    ? Icon(Icons.next_plan_sharp,
                                        color: AppColors.primaryColor)
                                    : Icon(Icons.next_plan_outlined,
                                        color: AppColors.greyColor)),
                            const SizedBox(height: 5),
                            Text("Plans",
                                style: _selectedIndex == 1
                                    ? textStyle(color: AppColors.primaryColor)
                                    : textStyle(color: AppColors.greyColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: _selectedIndex == 2
                                    ? Icon(Icons.explore,
                                        color: AppColors.primaryColor)
                                    : Icon(Icons.explore_outlined,
                                        color: AppColors.greyColor)),
                            const SizedBox(height: 5),
                            Text("Explore",
                                style: _selectedIndex == 2
                                    ? textStyle(color: AppColors.primaryColor)
                                    : textStyle(color: AppColors.greyColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Bounce(
                    duration: const Duration(milliseconds: 110),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: _selectedIndex == 3
                                    ? Icon(Icons.settings,
                                        color: AppColors.primaryColor)
                                    : Icon(Icons.settings_outlined,
                                        color: AppColors.greyColor)),
                            const SizedBox(height: 5),
                            Text("Settings",
                                style: _selectedIndex == 3
                                    ? textStyle(color: AppColors.primaryColor)
                                    : textStyle(color: AppColors.greyColor))
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
